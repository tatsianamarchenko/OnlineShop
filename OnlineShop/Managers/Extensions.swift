//
//  Extensions.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 11.04.22.
//

import Foundation
import UIKit

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


extension UIResponder {
	func next<T:UIResponder>(ofType: T.Type) -> T? {
		let r = self.next
		if let r = r as? T ?? r?.next(ofType: T.self) {
			return r
		} else {
			return nil
		}
	}
}

extension UITextField {
	func createCustomTextField(title: String) -> UITextField {
		let textField = UITextField()
		textField.keyboardType = .default
		textField.autocapitalizationType = .none
		textField.autocorrectionType = .no
		textField.placeholder = NSLocalizedString(title, comment: "")
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.font = UIFont.systemFont(ofSize: 20)
		textField.textAlignment = .left
		textField.textColor = Constants.shered.greenColor
		textField.clearButtonMode = .whileEditing
		textField.borderStyle = .roundedRect
		textField.layer.borderWidth = 0
		textField.layer.shadowColor = UIColor.systemGray.cgColor
		textField.layer.shadowOffset = CGSize(width: 0, height: 0)
		textField.layer.shadowRadius = 8
		textField.layer.shadowOpacity = 0.5
		textField.layer.masksToBounds = false
		return textField
	}
}

extension UIButton {
	func createCustomButton(title: String) -> IndexedButton {
		let button = IndexedButton(buttonIndexPath: IndexPath(index: 0))
		button.setTitle(title, for: .normal)
		button.setTitleColor(Constants.shered.greenColor, for: .selected)
		button.titleLabel?.textAlignment = .center
		button.accessibilityIdentifier = title
		button.backgroundColor = Constants.shered.greenColor
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 10
		return button
	}
}

extension UIView {
	func createCustomView() -> UIView {
		let mainView = UIView()
		mainView.translatesAutoresizingMaskIntoConstraints = false
		mainView.backgroundColor = .systemBackground
		mainView.layer.cornerRadius = 20
		mainView.layer.borderWidth = 0
		mainView.layer.shadowColor = UIColor.systemGray.cgColor
		mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
		mainView.layer.shadowRadius = 8
		mainView.layer.shadowOpacity = 0.5
		mainView.layer.masksToBounds = false
		return mainView
	}
}

extension UIView {

	static func spacer(size: CGFloat = 3, for layout: NSLayoutConstraint.Axis = .horizontal) -> UIView {
		let spacer = UIView()

		if layout == .horizontal {
			spacer.widthAnchor.constraint(equalToConstant: size).isActive = true
		} else {
			spacer.heightAnchor.constraint(equalToConstant: size).isActive = true
		}

		return spacer
	}

}
