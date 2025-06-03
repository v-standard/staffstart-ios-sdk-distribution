//
//  HandleError.swift
//  Example
//
//  Created by ohayoukenchan on 2025/04/18.
//  Copyright © 2025 VANISH STANDARD. All rights reserved.
//
import StaffStart__Core

@MainActor
func handleError(_ error: Error) {
    guard let error = error as? StaffStart__Core.StaffStartError else {
        return
    }

    switch error {
    case let .favoriteFailed(message),
         let .customerUserCodeNotFound(message):
        AlertState.shared.showAlert(
            title: "エラー",
            message: message
        )
    case let .favoriteFailedBecauseNotLoggedIn(message):
        AlertState.shared.showAlert(
            title: "ログインしてください",
            message: message
        )
    default:
        break
    }
}
