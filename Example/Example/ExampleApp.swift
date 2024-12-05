//
//  ExampleApp.swift
//  Example
//
//  Created by ohayoukenchan on 2024/10/08.
//
//

import StaffStart__App
import StaffStart__Core
import SwiftUI

@main
struct ExampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ExampleView()
            // APIの方を確認するにはContentView()を使ってください
            // ContentView()
        }
    }

    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication,
                         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
            StaffStartCore.configure()

            return true
        }
    }
}
