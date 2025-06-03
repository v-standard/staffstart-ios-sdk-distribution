//
//  HeaderView.swift
//  Example
//
//  Created by ohayoukenchan on 2025/05/27.
//  Copyright © 2025 VANISH STANDARD. All rights reserved.
//
import StaffStart__App
import StaffStart__Core
import SwiftUI

struct HeaderView: View {
    @State private var isLoggedIn = false
    @State private var useAlternateCustomerUserCode = false
    @State private var currentCustomerUserCode: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Text("YourApp")
                    .font(.headline)
                    .foregroundColor(.primary)

                Spacer()

                Button(action: {
                    isLoggedIn.toggle()
                    onLogin(isLoggedIn: isLoggedIn)
                }) {
                    Text(isLoggedIn ? "ログアウト" : "ログイン")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(isLoggedIn ? Color.red : Color.green)
                        .cornerRadius(8)
                }
            }

            if let code = currentCustomerUserCode, isLoggedIn {
                Text("ログイン中: \(code)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }

    private func onLogin(isLoggedIn: Bool) {
        if isLoggedIn {
            let dummyCustomerUserCode = if useAlternateCustomerUserCode {
                "YOUR_CUSTOMER_USER_CODE_2"
            } else {
                "YOUR_CUSTOMER_USER_CODE_1"
            }

            StaffStartCore.setCustomerUserCode(dummyCustomerUserCode)
            StaffStartUI.refresh()

            currentCustomerUserCode = dummyCustomerUserCode

            // 次回は逆を使うように切り替える
            useAlternateCustomerUserCode.toggle()
        } else {
            StaffStartCore.setCustomerUserCode(nil)
            StaffStartUI.refresh()

            currentCustomerUserCode = nil
        }
    }
}
