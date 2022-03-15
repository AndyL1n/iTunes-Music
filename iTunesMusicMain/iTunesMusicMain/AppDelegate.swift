//
//  AppDelegate.swift
//  iTunesMusicMain
//
//  Created by Andy on 2022/3/15.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAVSession()
        return true
    }

    
    private func setupAVSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay, .allowBluetooth])
            try AVAudioSession.sharedInstance().setActive(true)
            debugPrint("AVAudioSession setActive success")
        } catch let error {
            debugPrint(AError.custom(err: error.localizedDescription))
        }
    }
}
