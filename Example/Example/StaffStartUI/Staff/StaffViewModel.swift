//
//  CoordinateViewModel.swift
//  Example
//
//  Created by ohayoukenchan on 2024/11/13.
//  Copyright © 2024 VANISH STANDARD. All rights reserved.
//
import StaffStart__App
import StaffStart__Core
import SwiftUI

@MainActor
final class StaffViewModel: ObservableObject {
    @Published var staffListView: StaffStartView<AnyView>?
    @Published var isLoading: Bool = false

    func fetchStaffList() {
        isLoading = true

        Task {
            do {
                // サンプルのデータ取得処理
                let staffListView = try await StaffStartUI.getStaffListView()
                DispatchQueue.main.async {
                    // self.staffListView = staffListView
                    self.staffListView = staffListView
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.staffListView = nil
                }
            }
        }
    }
}
