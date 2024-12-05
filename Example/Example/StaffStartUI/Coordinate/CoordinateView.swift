//
//  CoordinateView.swift
//  Example
//
//  Created by ohayoukenchan on 2024/11/13.
//  Copyright © 2024 VANISH STANDARD. All rights reserved.
//
import SwiftUI

struct CoordinateView: View {
    @ObservedObject var viewModel: CoordinateViewModel

    // コーディネート詳細の商品選択時のコールバック
    var onSelectProduct: (String) -> Void

    public init(
        viewModel: CoordinateViewModel,
        onSelectProduct: @escaping (String) -> Void
    ) {
        self.viewModel = viewModel
        self.onSelectProduct = onSelectProduct
    }

    var body: some View {
        NavigationView {
            Group {
                if let coordinateListView = viewModel.coordinateView {
                    coordinateListView
                } else {
                    Text("コーディネートデータがありません")
                        .foregroundColor(.gray)
                }
            }
            .onAppear {
                if viewModel.coordinateView == nil {
                    viewModel.getCoordinateListView()
                }
            }
        }
    }
}
