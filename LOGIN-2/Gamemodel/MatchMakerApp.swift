///
/// MIT License
///
/// Copyright (c) 2020 Sascha Müllner
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.
///
/// Created by Sascha Müllner on 24.11.20.

import SwiftUI
import GameKit
import GameKitUI

@main
struct GKMatchMakerApp: App {
    @ObservedObject var viewModel = GKMatchMakerAppModel()
    public var body: some Scene {

        WindowGroup {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                ContentView()
                    .alert(isPresented: self.$viewModel.showAlert) {
                        Alert(title: Text(self.viewModel.alertTitle),
                              message: Text(self.viewModel.alertMessage),
                              dismissButton: .default(Text("Ok")))
                    }
                if self.viewModel.showAuthentication {
                    GKAuthenticationView { (error) in
                        self.viewModel.showAlert(title: "Authentication Failed", message: error.localizedDescription)
                    } authenticated: { (player) in
                        self.viewModel.showAuthentication = false
                    }
                } else if self.viewModel.showInvite {
                    GKInviteView(
                        invite: self.viewModel.invite.gkInvite!
                    ) {
                    } failed: { (error) in
                        self.viewModel.showAlert(title: "Invitation Failed", message: error.localizedDescription)
                    } started: { (gkMatch) in
                        self.viewModel.showInvite = false
                        self.viewModel.gkMatch = gkMatch
                    }
                } else if self.viewModel.showMatch,
                          let gkMatch = self.viewModel.gkMatch {
                    
                    MatchView( gkMatch)
                }
            }
        }
    }
}
//
//  AppDelegate.swift
//  GameCenterMultiplayer
//
//  Created by Pedro Contine on 29/06/20.
//

import UIKit


class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

