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
    var localAudioTrack = LocalAudioTrack()
    var localDataTrack = LocalDataTrack()
    lazy var localVideoTrack: LocalVideoTrack? = {
        guard let cameraSource = cameraSource else { return nil }
        return LocalVideoTrack(source: cameraSource, enabled: true, name: "Camera")
    }()
    lazy var cameraSource: CameraSource? = {
        return CameraSource(options: CameraSourceOptions(block: xcode10PlusBuilder), delegate: self)
    }()

    @IBOutlet weak var remoteView: VideoView!
    @IBOutlet weak var localView: VideoView!

    // MARK: - UI Lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tabBarItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "bubble.left.and.bubble.right"), selectedImage: UIImage(systemName: "bubble.left.and.bubble.right.fill"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLocalAudioTrack()
        prepareLocalVideoTrack()
    }

    // MARK: - Media Track Preparation

    private func prepareLocalAudioTrack() {
        // We will share local audio and video when we connect to the Room.
        if (localAudioTrack == nil) {
            localAudioTrack = LocalAudioTrack(options: nil, enabled: true, name: "Microphone")
            if (localAudioTrack == nil) {
                print("Failed to create audio track")
            }
        }
    }

    private func prepareLocalVideoTrack() {
        guard let cameraSource = cameraSource, let localVideoTrack = localVideoTrack else { return }

        // Add renderer to video track for local preview
        localVideoTrack.addRenderer(self.localView)

        // Add gesture recognizer to preview view
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.flipCamera))
        self.localView.addGestureRecognizer(tap)

        // Start capturing and displaying the local video preview
        guard let captureDevice = CameraSource.captureDevice(position: .front) ?? CameraSource.captureDevice(position: .front) else { return }
        cameraSource.startCapture(device: captureDevice) { (captureDevice, videoFormat, error) in
            if let error = error {
                print("Capture failed with error.\ncode = \((error as NSError).code) error = \(error.localizedDescription)")
            } else {
                self.localView.shouldMirror = (captureDevice.position == .front)
            }
        }
    }

    // MARK: - Twilio

    private func connectToVideoChat() {
        let connectOptions = ConnectOptions(token: PrivateConstants.twilioAccessToken2) { builder in
            // TODO: Set the roomName to that of the student username.
            // The teachers will then be able to select from students actively in rooms,
            // and connect to them via a simple tableView.
            builder.roomName = "room" // TODO: Change this when users are active!

            if let audioTrack = self.localAudioTrack {
                builder.audioTracks = [audioTrack]
            }
            if let dataTrack = self.localDataTrack {
                builder.dataTracks = [dataTrack]
            }
            if let videoTrack = self.localVideoTrack {
                builder.videoTracks = [videoTrack]
            }
        }
        videoChatRoom = TwilioVideoSDK.connect(options: connectOptions, delegate: self)
    }

    // MARK: - Helpers

    // TODO: @alan - Check to see if this is still needed in the future
    // Dated 12/10/19
    private func xcode10PlusBuilder(_ builder: CameraSourceOptionsBuilder) {
        // To support building with Xcode 10.x.
        #if XCODE_1100
        if #available(iOS 13.0, *) {
            // Track UIWindowScene events for the key window's scene.
            // The example app disables multi-window support in the .plist (see UIApplicationSceneManifestKey).
            builder.orientationTracker = UserInterfaceTracker(scene: UIApplication.shared.keyWindow!.windowScene!)
        }
        #endif
    }

    @objc func flipCamera() {
        guard let cameraSource = self.cameraSource, let captureDevice = cameraSource.device else { return }
        guard let newDevice = captureDevice.position == .front ? CameraSource.captureDevice(position: .back) : CameraSource.captureDevice(position: .front) else { return }
        cameraSource.selectCaptureDevice(newDevice) { (captureDevice, videoFormat, error) in
            if let error = error {
                print("Error selecting capture device.\ncode = \((error as NSError).code) error = \(error.localizedDescription)")
            } else {
                self.localView.shouldMirror = (captureDevice.position == .front)
            }
        }
    }

}

// MARK: - Twilio RoomDelegate

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

    func participantDidConnect(room: Room, participant: RemoteParticipant) {
        print("Someone connected to our room!")
    }
}

// MARK: - CameraSourceDelegate

extension VideoChatViewController: CameraSourceDelegate {
    func cameraSourceWasInterrupted(source: CameraSource, reason: AVCaptureSession.InterruptionReason) {
        localVideoTrack?.isEnabled = false
        // TODO: Show a "pause" screen here in the future.
    }

    func cameraSourceInterruptionEnded(source: CameraSource) {
        localVideoTrack?.isEnabled = true
        // TODO: Remove "pause" screen here in the future.
    }

    func cameraSourceDidFail(source: CameraSource, error: Error) {
        print("Oh nooo - camera source failed with error: \(error.localizedDescription)")
        // TODO: Figure out how to handle this fatal error.
    }
}

// MARK: - RemoteParticipantDelegate

extension VideoChatViewController: RemoteParticipantDelegate {

    // This is where we start rendering the remote participant's
    // video on to our local view.
    func didSubscribeToVideoTrack(videoTrack: RemoteVideoTrack, publication: RemoteVideoTrackPublication, participant: RemoteParticipant) {
        print("Hooray! Subscribed to the remote participant's video track.")
//        if let remoteView = VideoView.init(frame: self.view.bounds, delegate: self) {
//            remoteView.contentMode = .scaleAspectFill
//            videoTrack.addRenderer(remoteView)
//            self.view.addSubview(remoteView)
//            self.remoteView = remoteView
//        }
    }
}

// MARK: - VideoViewDelegate

extension VideoChatViewController: VideoViewDelegate {
    // Only called once when we receive the first frame of video.
    func videoViewDidReceiveData(view: VideoView) {
        print("First frame of video received!")
        // TODO: Update UI and remove potential "Loading" view
    }

    func videoViewDimensionsDidChange(view: VideoView, dimensions: CMVideoDimensions) {
        print("The dimensions of the video track changed to: \(dimensions.width)x\(dimensions.height)")
        self.view.setNeedsLayout()
    }
}
