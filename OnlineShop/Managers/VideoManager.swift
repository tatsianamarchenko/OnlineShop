//
//  VideoManager.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 13.04.22.
//

import Foundation
import AVKit

class VideoManager {
	var player: AVPlayer?
	var playerLayer: AVPlayerLayer?
	var view: UIView?
	init(view: UIView?) {
		self.view = view
	}

	func addToView(name: String, size: CGRect) {
		let bundle = Bundle.main.path(forResource: name, ofType: "mp4")
		guard let bundle = bundle else {
			return
		}
		let url = URL(fileURLWithPath: bundle)

		let item = AVPlayerItem(url: url)

		player = AVPlayer(playerItem: item)
		playerLayer = AVPlayerLayer(player: player)
		playerLayer?.frame = size
		guard let player = player else {
			return
		}

		guard let playerLayer = playerLayer else {
			return
		}

		view?.layer.insertSublayer(playerLayer, at: 0)
		player.playImmediately(atRate: 0.3)
	}
}

