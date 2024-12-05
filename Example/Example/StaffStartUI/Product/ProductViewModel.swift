//
//  ProductViewModel.swift
//  Example
//
//  Created by ohayoukenchan on 2024/11/29.
//  Copyright © 2024 VANISH STANDARD. All rights reserved.
//
import StaffStart__App
import StaffStart__Core
import SwiftUI

@MainActor
final class ProductViewModel: ObservableObject {
    @Published var coordinateBlockListView: StaffStartView<AnyView>?

    @Published var isLoading: Bool = false

    // コーディネートブロックで、コーディネート詳細をタップしたときのcidをViewのonChangeに伝えるためのプロパティ
    @Published var cidFromCoordinateBlockParts: Int?

    // コーディネートブロックで、もっと見るをタップしたときのbaseProductCodeをViewのonChangeに伝えるためのプロパティ
    @Published var baseProductCodeFromCoordinateBlockParts: String?

    func fetchCoordinateBlock(baseProductCode: String) {
        isLoading = true

        Task {
            do {
                let coordinateBlockListView = try await StaffStartUI.getCoordinateBlockView(
                    with: baseProductCode,
                    onTapCoordinateDetail: { cid in
                        self.showCoordinateDetail(with: cid)
                    },
                    onTapReadMore: { baseProductCode in
                        self.showCoordinateList(baseProductCode: baseProductCode)
                    }
                )
                DispatchQueue.main.async {
                    self.coordinateBlockListView = coordinateBlockListView
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.coordinateBlockListView = nil
                }
            }
        }
    }

    func showCoordinateDetail(with cid: Int) {
        isLoading = true

        Task {
            await StaffStartUI.showCoordinateDetail(with: cid)

            self.cidFromCoordinateBlockParts = cid

            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }

    func showCoordinateList(baseProductCode: String? = nil) {
        isLoading = true

        Task {
            await StaffStartUI.showCoordinateList(params: CoordinateListParams(baseProductCode: baseProductCode))

            self.baseProductCodeFromCoordinateBlockParts = baseProductCode

            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}
