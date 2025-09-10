import StaffStart__App
import StaffStart__Core
import StaffStart__Tracking
import SwiftUI

struct CoordinateView: View {
    @Binding var selectedSnapTab: CoordinateViewTab

    @ObservedObject var router: RoutingState

    @ObservedObject var favoriteRouter: RoutingState

    @StateObject private var productTabViewModel = ProductTabViewModel()

    @StateObject private var alertState = AlertState.shared

    var coordinateScreenID: String

    var staffScreenID: String

    var productScreenID: String

    var isFavorite: Bool

    var body: some View {
        VStack {
            Picker("Tabs", selection: $selectedSnapTab) {
                ForEach(CoordinateViewTab.allCases) { tab in
                    Text(tab.title)
                        .tag(tab)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // 各タブのビューを切り替え
            switch selectedSnapTab {
            case .product:
                ProductTabView(
                    screenID: productScreenID,
                    baseProductCode: productTabViewModel.baseProductCode,
                    onTapReadMore: { baseProductCode in
                        selectedSnapTab = .coordinate
                        routingState().snapPlayListPath.append(
                            Destination.snapPlayList(
                                params: CoordinateListParams(baseProductCode: baseProductCode),
                                screenID: UUID().uuidString
                            )
                        )
                    },
                    onTapSnapPlay: { cid in
                        selectedSnapTab = .coordinate
                        routingState().snapPlayListPath.append(
                            Destination.snapPlayDetail(cid: cid)
                        )
                        // コーデ詳細に遷移するときはページビューのトラッキングをお願いします
                        Task {
                            do {
                                try await StaffStartTracking.trackPageView(with: TrackingPageViewParams(
                                    contentID: cid,
                                    userID: StaffStartCore.getCustomerUserCode(), // 顧客IDが分かる場合こちらも送信してください
                                    contentType: .coordinate
                                ))
                            } catch {
                                print(error)
                            }
                        }
                    }
                )

            case .coordinate:
                SnapPlayTabView(
                    path: isFavorite ? $favoriteRouter.snapPlayListPath : $router.snapPlayListPath,
                    isFavorite: isFavorite,
                    snapPlayListView: staffStartSnapPlayListView(),
                    onTapProductItem: { baseProductCode in
                        selectedSnapTab = .product
                        productTabViewModel.updateBaseProductCode(baseProductCode)
                    }
                )

            case .staff:
                StaffTabView(
                    path: isFavorite ? $favoriteRouter.staffListPath : $router.staffListPath,
                    staffListView: staffStartStaffListView(),
                    onTapProduct: { baseProductCode in
                        selectedSnapTab = .product
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
                    do {
                        try await StaffStartTracking.trackPageView(with: TrackingPageViewParams(
                            contentID: cid,
                            userID: StaffStartCore.getCustomerUserCode(), // 顧客IDが分かる場合こちらも送信してください
                            contentType: .coordinate
                        ))
                    } catch {
                        print(error)
                    }
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
