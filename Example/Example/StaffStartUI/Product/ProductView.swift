//
//  ProductView.swift
//  Example
//
//  Created by ohayoukenchan on 2024/11/13.
//  Copyright © 2024 VANISH STANDARD. All rights reserved.
//
import StaffStart__Core
import SwiftUI

struct ProductView: View {
    @ObservedObject var viewModel: ProductViewModel

    // この画面でBaseProductCodeを表示するためのプロパティです
    var baseProductCode: String?

    var onSelectCoordinate: () -> Void

    var body: some View {
        VStack {
            if let baseProductCode {
                Text("Selected Product Code: \(baseProductCode)")
                    .font(.headline)
                Spacer()
            } else {
                VStack {
                    Text("No product selected")
                        .foregroundColor(.gray)
                    Spacer()
                }
            }

            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let coordinateBlockListView = viewModel.coordinateBlockListView {
                VStack {
                    coordinateBlockListView
                        .padding(.bottom, 30)
                }
            } else {
                Text("データを取得できませんでした。")
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            if let baseProductCode {
                viewModel.fetchCoordinateBlock(baseProductCode: baseProductCode)
            }
        }
        .onChange(of: viewModel.cidFromCoordinateBlockParts) {
            guard $0 != nil else { return }
            // コーディネートブロックから商品が選択されたらコールバックを呼び出す
            onSelectCoordinate()

            viewModel.cidFromCoordinateBlockParts = nil
        }
        .onChange(of: viewModel.baseProductCodeFromCoordinateBlockParts) {
            guard $0 != nil else { return }
            // コーディネートブロックのもっと見るを選択されたらコールバックを呼び出す
            onSelectCoordinate()

            // onchangeでは同一値が無視されるため一度状態をリセットしています
            viewModel.baseProductCodeFromCoordinateBlockParts = nil
        }
    }
}
