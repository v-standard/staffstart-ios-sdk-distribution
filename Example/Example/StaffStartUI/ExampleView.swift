//
//  ExampleView.swift
//  Example
//
//  Created by ohayoukenchan on 2024/10/08.
//
import StaffStart__App
import StaffStart__Core
import SwiftUI

struct ExampleView: View {
    @State private var selectedTab: Tab = .product

    // コーディネート詳細の商品パーツから取得した商品コード
    @State private var baseProductCodeFromCoordinateDetail: String?

    // baseProductCode
    @State var baseProductCode: String?

    @StateObject private var staffViewModel = StaffViewModel()
    @StateObject private var coordinateViewModel = CoordinateViewModel()
    @StateObject private var productViewModel = ProductViewModel()

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
            .onChange(of: selectedTab) { tab in
                switch tab {
                case .coordinate:
                    StaffStartUI.changeCurrentScene(scene: .coordinateList)
                case .staff:
                    StaffStartUI.changeCurrentScene(scene: .staffList)
                default:
                    break
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
                CoordinateView(
                    viewModel: coordinateViewModel,
                    // コーディネート詳細の商品パーツを選択したときの処理を登録
                    onSelectProduct: { baseProductCode in
                        baseProductCodeFromCoordinateDetail = baseProductCode
                    }
                )
            case .staff:
                StaffView(viewModel: staffViewModel)
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
            StaffStartUI.configure(configuration: StaffStartUIConfiguration(onTapProductItem: { baseProductCode in
                baseProductCodeFromCoordinateDetail = baseProductCode
            }))
        }
    }
}

#Preview {
    ExampleView()
}
