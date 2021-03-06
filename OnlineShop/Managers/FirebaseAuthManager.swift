//
//  FirebaseAuthManager.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 13.04.22.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager {

	static let shered = FirebaseAuthManager()
	private let firebaseManager = FirebaseDataBaseManager()
	public func insertUser(with user: AppUser,  completion: @escaping (Error?) -> Void) {
		Auth.auth().createUser(withEmail: user.email, password: user.passward) { authResult, error in
			if  error != nil {
				completion(error!)
			}
			else {
				self.firebaseManager.addUserToDatabase(with: user)
				UserDefaults.standard.set(user.email, forKey: Constants.shered.userKey)
				completion(nil)
			}
		}
	}

	public func enterUser(with email: String, passward: String, completion: @escaping((Result<(), Error>) -> Void)) {
		Auth.auth().signIn(withEmail: email, password: passward) { authResult, error in
			if  error != nil {
				completion(.failure(error!))
			}
			else {
				UserDefaults.standard.set(email, forKey: Constants.shered.userKey)
				completion(.success(()))
			}
		}
	}

	public func signOut (completion: @escaping(() -> Void)) {
		do {
			try Auth.auth().signOut()
			UserDefaults.standard.removeObject(forKey: Constants.shered.userKey)
			completion()
		} catch let error {
			print(error)
		}
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
