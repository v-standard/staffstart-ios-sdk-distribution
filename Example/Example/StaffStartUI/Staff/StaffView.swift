//
//  StaffView.swift
//  Example
//
//  Created by ohayoukenchan on 2024/11/13.
//  Copyright © 2024 VANISH STANDARD. All rights reserved.
//
import SwiftUI

struct StaffView: View {
    @ObservedObject var viewModel: StaffViewModel

    public init(viewModel: StaffViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let staffListView = viewModel.staffListView {
                    VStack {
                        staffListView
                    }
                } else {
                    Text("データを取得できませんでした。")
                        .foregroundColor(.red)
                }
            }
            .onAppear {
                viewModel.fetchStaffList()
            }
        }
    }
}
