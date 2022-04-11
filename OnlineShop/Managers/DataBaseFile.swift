//
//  DataBaseFile.swift
//  smes
//
//  Created by Tatsiana Marchanka on 27.10.21.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import Firebase

final class DataBaseManager {
	static let shered = DataBaseManager()

	/// sent new users to database
	public func insertUser(with user: AppUser,  completion: @escaping (Error) -> Void) {
		Auth.auth().createUser(withEmail: user.email, password: user.passward) { [weak self] authResult, error in
			if  error != nil {
				completion(error!)
			}
			else {
				// success
				let db = Firestore.firestore()
				db.collection("users").document(user.email).setData(["fullName": user.fullName,
																	 "phone": user.phone,
																	 "adress": user.adress,
																	 "zip": user.zip,
																	 "email": user.email,
																	 "passward": user.passward,
																	 "cart": [],
																	 "favorite": []]) { error in
					if error != nil {
						completion(error!)
					}
				}

				UserDefaults.standard.set(user.email, forKey: "user")
			}
		}
	}

	public func enterUser(with email: String, passward: String, completion: @escaping((Result<AuthDataResult, Error>) -> Void)) {
		Auth.auth().signIn(withEmail: email, password: passward) { [weak self] authResult, error in
			if  error != nil {
				completion(.failure(error!))
			}
			else {
				UserDefaults.standard.set(email, forKey: "user")
				completion(.success(authResult!))
			}
		}
	}

	public func signOut (completion: @escaping((Result<Void, Error>) -> Void)) {
		do {
			let a = try Auth.auth().signOut()
			completion(.success(a))
		} catch let error {
			completion(.failure(error))
		}
	}

	public func isPasswardValid(_ passward: String) -> Bool {
		let passwardPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
		return passwardPredicate.evaluate(with: passward)
	}

	struct AppUser {
		let fullName: String
		let phone: String
		let adress: String
		let zip: String
		let email: String
		let passward: String
	}

}


class IndexedButton: UIButton {
  var buttonIndexPath: IndexPath

  init(buttonIndexPath: IndexPath) {
	self.buttonIndexPath = buttonIndexPath
	super.init(frame: .zero)
  }
  required init?(coder aDecoder: NSCoder) {
	fatalError("init(coder:) has not been implemented")
  }
}
