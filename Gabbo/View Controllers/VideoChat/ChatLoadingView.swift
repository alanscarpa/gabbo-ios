//
//  ChatLoadingView.swift
//  Gabbo
//
//  Created by Alan Scarpa on 12/11/19.
//  Copyright © 2019 Gabbo. All rights reserved.
//

import UIKit

class ChatLoadingView: UIView {

    enum Status: String {
        case connecting = "Connecting..."
        // Although the chat is connected,
        // it still takes some time before the video starts rendering.
        case connected = "Connected! Pleae wait, loading video."
        // Once active, the video is ready to appear on screen.
        case active = ""
        case paused = "User paused video."
        case unpublished = "User unpublished video."
        case disconnecting = "Disconnecting"
        case disconnected = "User has left."
        case reconnecting = "Reconnecting..."
        case reconnected = "Reconnected! Pleae wait, loading video."
        case failedToConnect = "Failed to connect."
        case error = "There has been an error. Please try again."
        case participantConnected = "User connected."
    }

    @IBOutlet weak var statusLabel: UILabel!

    func setStatus(_ status: Status) {
        statusLabel.text = status.rawValue
        switch status {
        case .connecting, .disconnecting, .error, .connected, .unpublished, .paused, .disconnected, .reconnecting, .reconnected, .failedToConnect, .participantConnected:
            self.isHidden = false
        case .active:
            self.isHidden = true
        }
    }

}
