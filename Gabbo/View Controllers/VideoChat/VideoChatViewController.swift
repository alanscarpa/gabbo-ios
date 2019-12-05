//
//  VideoChatViewController.swift
//  Gabbo
//
//  Created by Alan Scarpa on 12/4/19.
//  Copyright © 2019 Gabbo. All rights reserved.
//

import UIKit
import TwilioVideo

class VideoChatViewController: UIViewController {

    var videoChatRoom: Room?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tabBarItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "bubble.left.and.bubble.right"), selectedImage: UIImage(systemName: "bubble.left.and.bubble.right.fill"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        connectToVideoChat()
    }

    private func connectToVideoChat() {
        let connectOptions = ConnectOptions(token: PrivateConstants.twilioAccessToken) { builder in
            // Not needed at the moment but it could be nice to have in the future.
            // I'm leaving this here as a reminder for now.
            // TODO: If this is still around 6/1/2020, delete me!
            // builder.roomName =
        }
        videoChatRoom = TwilioVideoSDK.connect(options: connectOptions, delegate: self)
    }

}

extension VideoChatViewController: RoomDelegate {
    func roomDidConnect(room: Room) {
        print("Yay! We connected to \(room.name)")
    }

    func roomDidDisconnect(room: Room, error: Error?) {
        print("Goodbye. Disconnecting from \(room.name)")
        if let error = error {
            print("Error on disconnect: \(error.localizedDescription)")
        }
    }

    func roomDidFailToConnect(room: Room, error: Error) {
        print("Oh no! Failed to connect with error: \(error.localizedDescription)")
    }
}
