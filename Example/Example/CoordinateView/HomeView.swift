//
//  HomeView.swift
//  Example
//
//  Created by ohayoukenchan on 2025/07/17.
//  Copyright © 2025 VANISH STANDARD. All rights reserved.
//

import StaffStart__App
import StaffStart__Core
import StaffStart__Tracking
import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: MainTab
    @Binding var selectedSnapTab: CoordinateViewTab

    var labelID: Int
    var snapRouter: RoutingState
    var brandCoordinateScreenID: String
    var brandStaffScreenID: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                makeTitle(text: "Coordinate")

                subTitleWithNavigation(text: "ALL", onTap: {
                    selectedTab = .snap
                    selectedSnapTab = .coordinate
                    snapRouter.snapPlayListPath.append(Destination.snapPlayList(params: CoordinateListParams(coordinateLabelIDList: [labelID]), screenID: UUID().uuidString))
                })

                StaffStartSnapPlayBlockView(
                    screenID: brandCoordinateScreenID,
                    coordinateListParams: CoordinateListParams(coordinateLabelIDList: [labelID]),
                    // titleを設定しないことでタイトルを非表示にできます
                    // title: "ここにタイトルを入力します",

                    // もっとみるボタンの制御
                    // shouldShowReadMoreはdefaultでtrueになっているので、必要に応じてfalseに設定してください
                    shouldShowReadMore: false,
                    shouldShowNoResult: true,
                    // onTapReadMore: { _ in },
                    onTapSnapPlay: { cid in
                        selectedTab = .snap
                        selectedSnapTab = .coordinate
                        snapRouter.snapPlayListPath.append(Destination.snapPlayDetail(cid: cid))

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
                    }, onFavoriteFailed: { error in
                        handleError(error)
                    }
                )

                makeTitle(text: "Staff")

                subTitleWithNavigation(text: "ALL", onTap: {
                    selectedTab = .snap
                    selectedSnapTab = .staff
                    snapRouter.staffListPath.append(Destination.staffList(params: StaffListParams(labelIDList: [labelID]), screenID: UUID().uuidString))
                })

                StaffStartStaffBlockView(
                    screenID: brandStaffScreenID,
                    staffListParams: StaffListParams(labelIDList: [labelID]),
                    onTapStaff: { id in
                        selectedTab = .snap
                        selectedSnapTab = .staff
                        snapRouter.staffListPath.append(Destination.staffDetail(id: id))
                    }, onFavoriteFailed: { error in
                        handleError(error)
                    }
                )
            }
            .padding(.vertical, 16)
        }
    }

    private func makeTitle(text: String) -> some View {
        Text(text)
            .bold()
            .padding(.horizontal, 16)
            .frame(height: 55)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray)
    }

    private func subTitleWithNavigation(text: String, onTap: (() -> Void)? = nil) -> some View {
        HStack {
            Text(text)
                .font(.title2)
                .bold()
                .padding(.horizontal, 16)
            Spacer()
            HStack {
                Text("もっと見る")
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .padding(.trailing, 16)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                onTap?()
            }
        }
    }
}
