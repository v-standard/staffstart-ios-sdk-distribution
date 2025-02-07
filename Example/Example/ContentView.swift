//
//  ContentView.swift
//  Example
//
//  Created by ohayoukenchan on 2024/10/08.
//
import StaffStart__App
import StaffStart__Core
import StaffStart__Tracking
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
//            ///
//            /// Coordinate確認用
//            /// Coordinateを確認する際にコメントアウトを外してください
//            ///
//            /// 初期化方法:
//            ///   Info.plistをご準備いただき、以下のキーを設定してください
//            ///     - MERCHANT_ID: Merchant ID
//            ///     - STAFF_START_API_URL: 別途ご指定させていただいたAPIのエンドポイント
//            ///     - STAFF_START_TRACKING_API_URL: 別途ご指定させていただいた計測用APIのエンドポイント
//            ///
//            ///   StaffStartCore.configure()で設定を読み込みます
//            ///
//            /// 📝 開発用コメント
//            /// 他の.task {} ですでにStaffStartCore.configure()が実行されている場合は不要です
//            ///
//            StaffStartCore.configure()
//            do {
//                /// Coordinate一覧の取得
//                /// 一覧を取得する際に使用してください
//                ///
//                /// - Throws: Error
//                /// - Returns: CoordinateListResponse
//                /// - Parameters: なし
//                ///
//                let coordinate = try await StaffStartApp.getCoordinateList(with: CoordinateListParams(
//                    sortType: .pv
//                ))
//                // print("(^θ^) + \(coordinate)")
//
//                /// Coordinate詳細の取得
//                /// 一覧などで取得したcidを指定してください
//                /// cidの検索にはStaffStartApp.getCoordinateList()を使用してください
//                ///
//                /// - Throws: Error
//                /// - Returns: CoordinateDetailResponse
//                /// - Parameters: cid: SNAP PLAYのコンテンツID
//                ///
//                let detail = try await StaffStartApp.getCoordinateDetail(with: 0)
//                print("(^θ^) + \(detail)")
//
//            } catch {
//                print("Error fetching coordinate: \(error)")
//            }
        }
        .task {
//            ///
//            /// Staff確認用
//            /// Staffを確認する際にコメントアウトを外してください
//            ///
//            /// 初期化方法:
//            ///   Info.plistをご準備いただき、以下のキーを設定してください
//            ///     - MERCHANT_ID: Merchant ID
//            ///     - STAFF_START_API_URL: 別途ご指定させていただいたAPIのエンドポイント
//            ///     - STAFF_START_TRACKING_API_URL: 別途ご指定させていただいた計測用APIのエンドポイント
//            ///
//            ///   StaffStartCore.configure()で設定を読み込みます
//            ///
//            /// 📝 開発用コメント
//            /// 他の.task {} ですでにStaffStartCore.configure()が実行されている場合は不要です
//
//            do {
//                StaffStartCore.configure()
//
//                /// StaffListの取得
//                /// getStaffDetailでUserIDを取得するのに使ってください
//                ///
//                /// - Throws: Error
//                /// - Returns: StaffListResponse
//                /// - Parameters:
//                ///  - with: StaffListParamsを指定してください
//                ///     - sortType: ソートタイプ
//                ///          - pv: PV数 降順（PVの多い順）
//                ///          - time: 最新コンテンツの公開日時 降順（新しい順）
//                ///     - count: 取得数
//                ///         - 1〜120件の間で指定してください
//                ///         - デフォルト値は30です
//                ///
//                let staffList = try await StaffStartApp.getStaffList(with: StaffListParams(
//                    sortType: .time,
//                    count: 10
//                ))
//                print("(^θ^) + StaffList \(staffList.item.first?.userID ?? 0)")
//
//                /// StaffDetailの取得
//                /// 0はダミー値です
//                ///
//                /// - Throws: Error
//                /// - Returns: StaffDetailResponse
//                /// - Parameters: userID: STAFF STARTで採番されたスタッフID
            ////                let staff = try await StaffStartApp.getStaffDetail(userID: 0)
            ////                print("(^θ^) + StaffDetail \(staff)")
//            } catch {
//                switch error {
//                case let StaffStartError.invalidConfiguration(message):
//                    print(message)
//                    print("(^θ^) + ニコニコ")
//                default:
//                    print("Error fetching staff: \(error)")
//                }
//            }
        }
        .task {
            ///
            /// Tracking確認用
            /// トラッキングを確認する際にコメントアウトを外してください
            ///
            /// 初期化方法:
            ///   Info.plistをご準備いただき、以下のキーを設定してください
            ///     - MERCHANT_ID: Merchant ID
            ///     - STAFF_START_API_URL: 別途ご指定させていただいたAPIのエンドポイント
            ///     - STAFF_START_TRACKING_API_URL: 別途ご指定させていただいた計測用APIのエンドポイント
            ///
            ///   StaffStartCore.configure()で設定を読み込みます
            ///
            /// 📝 開発用コメント
            /// 他の.task {} ですでにStaffStartCore.configure()が実行されている場合は不要です
//            StaffStartCore.configure()
//            do {
//                /// PageViewの確認
//                ///
//                /// - Throws: Error: TODO: エラーの詳細を決める
//                /// - Returns: 成功レスポンスと場合返り値はありません
//                /// - Parameters:
//                ///   - with: TrackingPageViewParamsを指定してください
//                ///     - contentID: SNAP PLAYのコンテンツID(cid)
//                ///     - userID: ECサイト側の顧客ID 未ログイン時はnilを許容します
//                try await StaffStartTracking.trackPageView(with: TrackingPageViewParams(
//                    contentID: 1,
//                    userID: "12345"
//                ))
//
//                /// AddToCartの確認
//                ///
//                /// - Throws: Error: TODO: エラーの詳細を決める
//                /// - Returns: 成功レスポンスと場合返り値はありません
//                /// - Parameters:
//                ///  - with: TrackingAddToCartParamsを指定してください
//                ///  - sku: 商品のSKU
//                ///  - count: 商品の数量
//                ///
//                try await StaffStartTracking.trackAddToCart(with: TrackingAddToCartParams(
//                    sku: "aaa",
//                    count: 1
//                ))
//
//                /// 購入の確認
//                /// - Throws: Error: TODO: エラーの詳細を決める
//                /// - Returns: 成功レスポンスと場合返り値はありません
//                /// - Parameters:
//                ///  - with: TrackingPurchaseParamsを指定してください
//                ///  - userID: ECサイト側の顧客ID
//                ///  - orderID: ECサイト側の注文ID
//                ///  - productInfo: 商品情報
//                ///     - sku: 商品のSKU
//                ///     - price: 商品の価格
//                ///     - count: 商品の数量
//                ///
//                try await StaffStartTracking.trackPurchase(with: TrackingPurchaseParams(
//                    userID: "12345",
//                    orderID: "12345",
//                    productInfo: [
//                        TrackingProductInfo(sku: "100", price: 1000, count: 1),
//                        TrackingProductInfo(sku: "200", price: 2000, count: 3)
//                    ]
//                ))
//
//                /// PageViewの確認
//                /// c_sstagが変更されることを確認できます
//                try await StaffStartTracking.trackPageView(with: TrackingPageViewParams(
//                    contentID: 2,
//                    userID: "12345"
//                ))
//            } catch {
//                print("Error tracking \(error)")
//            }
        }
    }
}

#Preview {
    ContentView()
}
