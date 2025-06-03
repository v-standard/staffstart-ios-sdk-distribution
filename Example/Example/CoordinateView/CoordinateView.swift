import StaffStart__App
import StaffStart__Core
import StaffStart__Tracking
import SwiftUI

struct CoordinateView: View {
    @State private var selectedTab: Tab = .product

    @StateObject private var router = RoutingState()

    @StateObject private var favoriteRouter = RoutingState()

    @StateObject private var productTabViewModel = ProductTabViewModel()

    @StateObject private var alertState = AlertState.shared

    var coordinateScreenID: String

    var staffScreenID: String

    var isFavorite: Bool

    init(coordinateScreenID: String, staffScreenID: String, isFavorite: Bool = false) {
        self.coordinateScreenID = coordinateScreenID
        self.staffScreenID = staffScreenID
        self.isFavorite = isFavorite
    }

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
                        routingState().snapPlayListPath.append(
                            Destination.snapPlayList(
                                params: CoordinateListParams(baseProductCode: baseProductCode),
                                screenID: UUID().uuidString
                            )
                        )
                    },
                    onTapSnapPlay: { cid in
                        selectedTab = .coordinate
                        routingState().snapPlayListPath.append(
                            Destination.snapPlayDetail(cid: cid)
                        )
                    }
                )

            case .coordinate:
                SnapPlayTabView(
                    path: isFavorite ? $favoriteRouter.snapPlayListPath : $router.snapPlayListPath,
                    snapPlayListView: staffStartSnapPlayListView(),
                    onTapProductItem: { baseProductCode in
                        selectedTab = .product
                        productTabViewModel.updateBaseProductCode(baseProductCode)
                    }
                )

            case .staff:
                StaffTabView(
                    path: isFavorite ? $favoriteRouter.staffListPath : $router.staffListPath,
                    staffListView: staffStartStaffListView(),
                    onTapProduct: { baseProductCode in
                        selectedTab = .product
                        productTabViewModel.updateBaseProductCode(baseProductCode)
                    }
                )
            }
        }
    }

    /// StaffStartSnapPlayListViewを都度生成するのを回避するためbodyの外で生成しています
    private func staffStartSnapPlayListView() -> StaffStartSnapPlayListView {
        StaffStartSnapPlayListView(
            /// 絞り込み検索条件をSDKで保持している条件に復元するためscreenIDからクエリを復元するのに必要です
            screenID: coordinateScreenID,
            coordinateListParams: CoordinateListParams(isFavorite: isFavorite),
            onTapSnapPlay: { cid in
                routingState().snapPlayListPath.append(Destination.snapPlayDetail(cid: cid))
                /// **コーディネート詳細を表示するタイミングで送信いただく必要があります**
                Task {
                    await Tracker.shared.trackPageView(with: cid)
                }
            },
            onFavoriteFailed: { error in
                handleError(error)
            }
        )
    }

    /// StaffStartStaffListViewを都度生成するのを回避するためbodyの外で生成しています
    private func staffStartStaffListView() -> StaffStartStaffListView {
        StaffStartStaffListView(
            /// 絞り込み検索条件をSDKで保持している条件に復元するためscreenIDからクエリを復元するのに必要です
            screenID: staffScreenID,
            staffListParams: StaffListParams(isFavorite: isFavorite),
            onTapStaff: { userID in
                routingState().staffListPath.append(Destination.staffDetail(id: userID))
            },
            onFavoriteFailed: { error in
                handleError(error)
            }
        )
    }

    private func routingState() -> RoutingState {
        isFavorite ? favoriteRouter : router
    }
}
