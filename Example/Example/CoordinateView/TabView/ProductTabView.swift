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
    var baseProductCode: String?

    var onTapReadMore: (_ baseProductCode: String) -> Void

    var onTapSnapPlay: (_ cid: Int) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("商品詳細").font(.title).padding(.bottom, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            if let baseProductCode {
                StaffStartSnapPlayBlockView(coordinateListParams: CoordinateListParams(
                    baseProductCode: baseProductCode
                ), onTapReadMore: { baseProductCode in
                    onTapReadMore(baseProductCode)
                }, onTapSnapPlay: { cid in
                    onTapSnapPlay(cid)
                    Task {
                        await Tracker.shared.trackPageView(with: cid)
                    }
                }, onFavoriteFailed: { error in
                    handleError(error)
                })
            }
        }
        .padding()
    }
}
