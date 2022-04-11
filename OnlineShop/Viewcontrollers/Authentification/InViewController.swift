//
//  InViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 10.04.22.
//

import UIKit
import AVKit

class InViewController: UIViewController {
	private var player: AVPlayer?
	private var playerLayer: AVPlayerLayer?
	private lazy var  createAccountButton = UIButton().createCustomButton(title: "create account")

	private lazy var  enterButton = UIButton().createCustomButton(title: "log in")

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		view.addSubview(createAccountButton)
		view.addSubview(enterButton)
		createAccountButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
		enterButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
		makeConstraints()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	let bundle = Bundle.main.path(forResource: "videomain", ofType: "mp4")
		guard let bundle = bundle else {
			return
		}
		let url = URL(fileURLWithPath: bundle)

		let item = AVPlayerItem(url: url)

		player = AVPlayer(playerItem: item) 
		playerLayer = AVPlayerLayer(player: player)
		playerLayer?.frame = CGRect(x: -30, y: 0, width: self.view.frame.size.width*1.3, height: self.view.frame.size.height)
		guard let player = player else {
			return
		}

		guard let playerLayer = playerLayer else {
			return
		}

		view.layer.insertSublayer(playerLayer, at: 0)
		player.playImmediately(atRate: 0.3)
	}

	@objc private func tapped(_ button: UIButton) {
		if button.accessibilityIdentifier == "create account" {
			let vc = NewAccountViewController()
			present(vc, animated: true)
		} else {
			let vc = EnterViewController()
			present(vc, animated: true)
		}
	}

	private func makeConstraints() {
		NSLayoutConstraint.activate([
		createAccountButton.bottomAnchor.constraint(equalTo: enterButton.topAnchor, constant: -10),
		createAccountButton.heightAnchor.constraint(equalToConstant: 50),
		createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
		createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

		enterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
		enterButton.heightAnchor.constraint(equalToConstant: 50),
		enterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
		enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
		])
	}
}
