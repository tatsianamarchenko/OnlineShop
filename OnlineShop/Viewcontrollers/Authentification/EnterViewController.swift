//
//  EnterViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 9.04.22.
//

import UIKit

class EnterViewController: UIViewController {

	private lazy var accountImageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(systemName: "person")?.withTintColor(Constants.shered.greenColor, renderingMode: .alwaysOriginal)
		image.backgroundColor = Constants.shered.whiteColor
		image.clipsToBounds = true
		image.contentMode = .scaleAspectFill
		return image
	}()

	private lazy var emailTextField = UITextField().createCustomTextField(title: "Enter e-mail")
	private lazy var passwardTextField = UITextField().createCustomTextField(title: "Enter passward")

	private lazy var logInButton: UIButton = {
		var button = UIButton()
		button.setTitle("Log in", for: .normal)
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
		view.addSubview(passwardTextField)
		view.addSubview(emailTextField)
		view.addSubview(logInButton)
		logInButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
		emailTextField.delegate = self
		passwardTextField.delegate = self
		makeConstraints()
	}

	private func makeConstraints() {
		NSLayoutConstraint.activate([
			accountImageView.widthAnchor.constraint(equalToConstant: view.frame.width/4),
			accountImageView.heightAnchor.constraint(equalToConstant: 100),
			accountImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			accountImageView.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -20),

			emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

			passwardTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
			passwardTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			passwardTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

			logInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
			logInButton.heightAnchor.constraint(equalToConstant: 50),
			logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
		])
	}

	override func viewDidLayoutSubviews() {
	  super.viewDidLayoutSubviews()
		accountImageView.layer.cornerRadius = 10
	}

	@objc private func enterButtonTapped() {

		emailTextField.resignFirstResponder()
		passwardTextField.resignFirstResponder()

		guard let  email = emailTextField.text,
			  let passward = passwardTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
			 !email.isEmpty, !passward.isEmpty else {
				  self.alertUserLoginError(string: "enter all information to create a new account")
				  return
			  }

		FirebaseAuthManager.shered.enterUser(with: email, passward: passward) { (result: Result<Void, Error>) in
			switch result {
			case .success(_):
				let vc = MainTabBarController()
				vc.modalPresentationStyle = .fullScreen
				self.present(vc, animated: true)
			case .failure(let failure):
				self.alertUserLoginError(string: failure.localizedDescription)
			}

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
}

extension EnterViewController : UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == emailTextField {
			textField.resignFirstResponder()
			passwardTextField.becomeFirstResponder()
		} else if textField == passwardTextField {
			textField.resignFirstResponder()
		} else {
			textField.resignFirstResponder()
		}
		return true
	}
}

