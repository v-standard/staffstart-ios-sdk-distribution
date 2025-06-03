//
//  MainTabView.swift
//  Example
//
//  Created by ohayoukenchan on 2025/04/17.
//  Copyright © 2025 VANISH STANDARD. All rights reserved.
//
import SwiftUI

enum MainTab: Hashable {
    case snap
    case favorite

    var title: String {
        switch self {
        case .snap: "コーデ"
        case .favorite: "お気に入り"
        }
    }

    var systemImageName: String {
        switch self {
        case .snap: "photo.on.rectangle"
        case .favorite: "heart.fill"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: MainTab = .snap

    @StateObject private var alertState = AlertState.shared

    var rootCoordinateScreenID = UUID().uuidString

    var rootStaffScreenID = UUID().uuidString

    var rootFavoriteCoordinateScreenID = UUID().uuidString

    var rootFavoriteStaffScreenID = UUID().uuidString

    var body: some View {
        HeaderView()

        TabView(selection: $selectedTab) {
            CoordinateView(coordinateScreenID: rootCoordinateScreenID, staffScreenID: rootStaffScreenID)
                .tabItem {
                    Label(MainTab.snap.title, systemImage: MainTab.snap.systemImageName)
                }
                .tag(MainTab.snap)

            CoordinateView(coordinateScreenID: rootFavoriteCoordinateScreenID, staffScreenID: rootFavoriteStaffScreenID, isFavorite: true)
                .tabItem {
                    Label(MainTab.favorite.title, systemImage: MainTab.favorite.systemImageName)
                }
                .tag(MainTab.favorite)
        }
        .alert(alertState.title, isPresented: $alertState.isPresented) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertState.message)
        }
    }
}
