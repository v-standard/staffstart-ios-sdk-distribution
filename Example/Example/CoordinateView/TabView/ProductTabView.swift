//
//  ProductTabView.swift
//  Example
//
//  Created by ohayoukenchan on 2025/03/14.
//  Copyright © 2025 VANISH STANDARD. All rights reserved.
//
import StaffStart__App
import StaffStart__Core
import StaffStart__Tracking
import SwiftUI

struct ProductTabView: View {
    var screenID: String

    var baseProductCode: String?

    var onTapReadMore: (_ baseProductCode: String) -> Void

    var onTapSnapPlay: (_ cid: Int) -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("商品詳細").font(.title).padding(.bottom, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)

                if let baseProductCode {
                    StaffStartSnapPlayBlockView(
                        screenID: screenID,
                        coordinateListParams: CoordinateListParams(
                            baseProductCode: baseProductCode,
                        ),
                        // titleを設定することでタイトルを表示できます
                        title: "この商品を使ったコーディネート",
                        // もっとみるボタンの制御
                        // もっとみるボタンはデフォルトでtrueが設定されているためtrueの場合あえて設定する必要はありません
                        // shouldShowReadMore: true,

                        shouldShowNoResult: false,
                        onTapReadMore: { baseProductCode in
                            onTapReadMore(baseProductCode)
                        }, onTapSnapPlay: { cid in
                            onTapSnapPlay(cid)
                            Task {
                                do {
                                    try await StaffStartTracking.trackPageView(
                                        with: TrackingPageViewParams(
                                            contentID: cid,
                                            userID: StaffStartCore.getCustomerUserCode(),
                                            contentType: .coordinate
                                        )
                                    )
                                } catch {
                                    print("trackPageView failed: \(error)")
                                }
                            }
                        }, onFavoriteFailed: { error in
                            handleError(error)
                        }
                    )
                }

                Spacer()
            }
            .padding(.vertical, 16)
        }
    }
}
