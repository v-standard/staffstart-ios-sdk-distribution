//
//  CoordinateViewModel.swift
//  Example
//
//  Created by ohayoukenchan on 2024/11/21.
//  Copyright © 2024 VANISH STANDARD. All rights reserved.
//
import StaffStart__App
import StaffStart__Core
import SwiftUI

@MainActor
final class CoordinateViewModel: ObservableObject {
    // コーディネート画面
    @Published var coordinateView: StaffStartView<AnyView>?

    func getCoordinateListView() {
        Task {
            do {
                // コーディネート一覧画面を取得してセットする
                let coordinateView = try await StaffStartUI.getCoordinateListView()

                DispatchQueue.main.async {
                    self.coordinateView = coordinateView
                }
            } catch {
                DispatchQueue.main.async {
                    self.coordinateView = nil
                }
            }
        }
    }
}
