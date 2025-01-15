//
//  ExampleView.swift
//  Example
//
//  Created by ohayoukenchan on 2024/10/08.
//
import StaffStart__App
import StaffStart__Core
import StaffStart__Tracking
import SwiftUI

struct ExampleView: View {
    @State private var selectedTab: Tab = .product

    // コーディネート詳細の商品パーツから取得した商品コード
    @State private var baseProductCodeFromCoordinateDetail: String?

    // baseProductCode
    @State var baseProductCode: String?

    @StateObject private var productViewModel = ProductViewModel()

    let coordinateView: some View = StaffStartUI.snapPlayListView()

    let staffView: some View = StaffStartUI.staffListView()

    enum Tab: String, CaseIterable, Identifiable, Sendable {
        case product
        case coordinate
        case staff

        var id: String { rawValue }

        var title: String {
            switch self {
            case .product: "商品"
            case .coordinate: "コーディネート"
            case .staff: "スタッフ"
            }
        }
    }

    var body: some View {
        VStack {
            Picker("Tabs", selection: $selectedTab) {
                ForEach(Tab.allCases) { tab in
                    Text(tab.title)
                        .tag(tab)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // 選択したタブのビューを表示
            switch selectedTab {
            case .product:
                ProductView(
                    viewModel: productViewModel,
                    baseProductCode: baseProductCode,
                    onSelectCoordinate: {
                        selectedTab = .coordinate
                    }
                )
            case .coordinate:
                coordinateView
            case .staff:
                staffView
            }
        }
        .onChange(of: baseProductCodeFromCoordinateDetail) { baseProductCode in
            guard let baseProductCode else { return }
            // 商品タブに切り替えて商品コードを保持
            selectedTab = .product

            self.baseProductCode = baseProductCode

            baseProductCodeFromCoordinateDetail = nil
        }
        .onAppear {
            StaffStartUI.configure(configuration: StaffStartUIConfiguration(
                onTapProductItem: { baseProductCode in
                    baseProductCodeFromCoordinateDetail = baseProductCode
                },
                onShowCoordinateDetail: { cid in
                    Task {
                        try? await StaffStartTracking.trackPageView(with: TrackingPageViewParams(
                            contentID: cid,
                            userID: nil, // ここはnilで構いません
                            contentType: .coordinate
                        ))
                    }
                }
            ))
        }
        .animation(nil, value: selectedTab)
    }
}
