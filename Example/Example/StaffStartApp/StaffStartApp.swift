import StaffStart__App
import StaffStart__Core
import StaffStart__Tracking
import SwiftUI

struct StaffStartApp: View {
    @State private var selectedTab: Tab = .product

    @StateObject private var router = RoutingState.shared

    @StateObject private var productTabViewModel = ProductTabViewModel()

    /// StaffStartSnapPlayListViewを都度生成するのを回避するためbodyの外で生成しています
    private var staffStartSnapPlayListView =
        StaffStartSnapPlayListView(
            /// 絞り込み検索条件をSDKで保持している条件に復元するためscreenIDからクエリを復元するのに必要です
            screenID: UUID().uuidString,
            coordinateListParams: CoordinateListParams(),
            onTapSnapPlay: { cid in
                RoutingState.shared.snapPlayListPath.append(Destination.snapPlayDetail(cid: cid))
                /// **コーディネート詳細を表示するタイミングで送信いただく必要があります**
                Task {
                    await Tracker.shared.trackPageView(with: cid)
                }
            }
        )

    /// StaffStartStaffListViewを都度生成するのを回避するためbodyの外で生成しています
    private var staffStartStaffListView = StaffStartStaffListView(
        /// 絞り込み検索条件をSDKで保持している条件に復元するためscreenIDからクエリを復元するのに必要です
        screenID: UUID().uuidString,
        staffListParams: StaffListParams(),
        onTapStaff: { userID in
            RoutingState.shared.staffListPath.append(Destination.staffDetail(id: userID))
        }
    )

    /// SDKのデモでタブ切り替えを行うためのタブ情報
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

            // 各タブのビューを切り替え
            switch selectedTab {
            case .product:
                ProductTabView(
                    baseProductCode: productTabViewModel.baseProductCode,
                    onTapReadMore: { baseProductCode in
                        selectedTab = .coordinate
                        RoutingState.shared.snapPlayListPath.append(
                            Destination.snapPlayList(
                                params: CoordinateListParams(baseProductCode: baseProductCode),
                                screenID: UUID().uuidString
                            )
                        )
                    },
                    onTapSnapPlay: { cid in
                        selectedTab = .coordinate
                        RoutingState.shared.snapPlayListPath.append(Destination.snapPlayDetail(cid: cid))
                    }
                )

            case .coordinate:
                SnapPlayTabView(
                    path: $router.snapPlayListPath,
                    snapPlayListView: staffStartSnapPlayListView,
                    onTapProductItem: { baseProductCode in
                        selectedTab = .product
                        productTabViewModel.updateBaseProductCode(baseProductCode)
                    }
                )

            case .staff:
                StaffTabView(
                    path: $router.staffListPath,
                    staffListView: staffStartStaffListView,
                    onTapProduct: { baseProductCode in
                        selectedTab = .product
                        productTabViewModel.updateBaseProductCode(baseProductCode)
                    }
                )
            }
        }
    }
}
