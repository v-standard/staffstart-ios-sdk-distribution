//
//  AlertState.swift
//  Example
//
//  Created by ohayoukenchan on 2025/04/18.
//  Copyright © 2025 VANISH STANDARD. All rights reserved.
//
import SwiftUI

@MainActor
final class AlertState: ObservableObject {
    static let shared = AlertState()

    @Published var isPresented: Bool = false
    @Published var title: String = ""
    @Published var message: String = ""
    @Published var dismissButtonTitle: String = "OK"

    func showAlert(title: String, message: String) {
        self.title = title
        self.message = message
        self.isPresented = true
    }

    func hideAlert() {
        self.isPresented = false
    }
}
