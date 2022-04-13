//
//  NewAccountViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 9.04.22.
//

import UIKit

class NewAccountViewController: UIViewController {

	private lazy var accountImageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(systemName: "person")?.withTintColor(Constants.shered.greenColor, renderingMode: .alwaysOriginal)
		image.backgroundColor = Constants.shered.whiteColor
		image.clipsToBounds = true
		image.contentMode = .scaleAspectFill
		return image
	}()

	private lazy var fullNameTextField = UITextField().createCustomTextField(title: "Enter full name")
	private lazy var emailTextField = UITextField().createCustomTextField(title: "Enter e-mail")
	private lazy var passwardTextField = UITextField().createCustomTextField(title: "Enter passward")
	private lazy var adressTextField = UITextField().createCustomTextField(title: "Enter adress")
	private lazy var phoneTextField = UITextField().createCustomTextField(title: "Enter phone")
	private lazy var zipTextField = UITextField().createCustomTextField(title: "Enter zip adress")

	private lazy var signUpButton: UIButton = {
		var button = UIButton()
		button.setTitle("Sign Up", for: .normal)
		button.titleLabel?.textAlignment = .center
		button.backgroundColor = Constants.shered.greenColor
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 10
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		view.addSubview(accountImageView)
		view.addSubview(fullNameTextField)
		view.addSubview(passwardTextField)
		view.addSubview(emailTextField)
		view.addSubview(adressTextField)
		view.addSubview(phoneTextField)
		view.addSubview(zipTextField)
		view.addSubview(signUpButton)

		fullNameTextField.delegate = self
		emailTextField.delegate = self
		passwardTextField.delegate = self
		adressTextField.delegate = self
		phoneTextField.delegate = self
		zipTextField.delegate = self

		makeConstraints()
		signUpButton.addTarget(self, action: #selector(registrationFinishButtonTapped), for: .touchUpInside)
		let gesture = UITapGestureRecognizer(target: self, action: #selector(profileImage))
		accountImageView.isUserInteractionEnabled = true
		accountImageView.addGestureRecognizer(gesture)
	}

	private func makeConstraints() {
		NSLayoutConstraint.activate([
			accountImageView.widthAnchor.constraint(equalToConstant: view.frame.width/4),
			accountImageView.heightAnchor.constraint(equalToConstant: 100),
			accountImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			accountImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

			fullNameTextField.topAnchor.constraint(equalTo: accountImageView.bottomAnchor, constant: 20),
			fullNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			fullNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

			emailTextField.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 20),
			emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

			passwardTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
			passwardTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			passwardTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

			adressTextField.topAnchor.constraint(equalTo: passwardTextField.bottomAnchor, constant: 20),
			adressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			adressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

			phoneTextField.topAnchor.constraint(equalTo: adressTextField.bottomAnchor, constant: 20),
			phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

			zipTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
			zipTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			zipTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

			signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
			signUpButton.heightAnchor.constraint(equalToConstant: 50),
			signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
		])
	}

	override func viewDidLayoutSubviews() {
	  super.viewDidLayoutSubviews()
		accountImageView.layer.cornerRadius = 10
	}

	@objc private func profileImage() {
		presentPhoto()
	}

	@objc private func registrationFinishButtonTapped() {

		emailTextField.resignFirstResponder()
		passwardTextField.resignFirstResponder()
		fullNameTextField.resignFirstResponder()
		adressTextField.resignFirstResponder()
		phoneTextField.resignFirstResponder()
		zipTextField.resignFirstResponder()
		
		guard let fullName = fullNameTextField.text,
			  let phone = phoneTextField.text,
			  let adress = adressTextField.text,
			  let zip = zipTextField.text,
			  let  email = emailTextField.text,
			  let passward = passwardTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
			  !fullName.isEmpty, !phone.isEmpty, !adress.isEmpty, !zip.isEmpty, !email.isEmpty, !passward.isEmpty else {
				  self.alertUserLoginError(string: "enter all information to create a new account")
				  return
			  }
		if isPasswardValid(passward) == false {
			self.alertUserLoginError(string: "please make sure passward is secure enought")
		}
		let user = FirebaseAuthManager.AppUser(fullName: fullName, phone: phone, adress: adress, zip: zip, email: email, passward: passward)
		FirebaseAuthManager.shered.insertUser(with: user) { error in
				self.alertUserLoginError(string: error.localizedDescription)
		}
		let vc = MainTabBarController()
		vc.modalPresentationStyle = .fullScreen
		self.present(vc, animated: true)
	}

	private func alertUserLoginError(string message: String) {
		let alert = UIAlertController(title: "error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
		present(alert, animated: true)
	}

	private func isPasswardValid(_ passward: String) -> Bool {
		let passwardPredicate = NSPredicate(format: "SELF MATCHES %@", Constants.shered.validationPredicate)
		return passwardPredicate.evaluate(with: passward)
	}
}

extension NewAccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	func photoWithCamera(){
		let vc = UIImagePickerController()
		vc.sourceType = .camera
		vc.delegate = self
		vc.allowsEditing = true
		present(vc, animated: true)
	}
	func photoFromLibrary(){
		let vc = UIImagePickerController()
		vc.sourceType = .photoLibrary
		vc.delegate = self
		vc.allowsEditing = true
		present(vc, animated: true)
	}
	
	func presentPhoto(){
		let choose = UIAlertController(title: "Profile Photo", message: "How would you like to select a photo?", preferredStyle: .actionSheet)
		let library = UIAlertAction(title: "photo library", style: .default, handler: {[weak self] _ in self?.photoFromLibrary() } )
		let camera = UIAlertAction(title: "take photo", style: .default, handler: {[weak self] _ in self?.photoWithCamera()} )
		let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
		choose.addAction(library)
		choose.addAction(camera)
		choose.addAction(cancel)
		present(choose, animated: true)
	}

	func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any] ) {
		picker.dismiss(animated: true, completion: nil)
		guard  let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
			return
		}
		self.accountImageView.image = selectedImage
	}
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true, completion: nil)
	}
}

extension NewAccountViewController : UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == fullNameTextField {
			textField.resignFirstResponder()
			emailTextField.becomeFirstResponder()
		} else if textField == emailTextField {
			textField.resignFirstResponder()
			passwardTextField.becomeFirstResponder()
		} else if textField == passwardTextField {
			if isPasswardValid((passwardTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) ?? "") == false {
				// passward isn't secure enought
				self.alertUserLoginError(string: "please make sure passward is secure enought")
			}
			textField.resignFirstResponder()
			adressTextField.becomeFirstResponder()
		} else if textField == adressTextField {
			textField.resignFirstResponder()
			phoneTextField.becomeFirstResponder()
		} else if textField == phoneTextField {
			textField.resignFirstResponder()
			zipTextField.becomeFirstResponder()
		} else if textField == zipTextField {
			textField.resignFirstResponder()
		} else {
			textField.resignFirstResponder()
		}
		return true
	}
}
