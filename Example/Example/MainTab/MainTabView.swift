//
//  MainTabView.swift
//  Example
//
//  Created by ohayoukenchan on 2025/04/17.
//  Copyright © 2025 VANISH STANDARD. All rights reserved.
//
import SwiftUI

enum MainTab: Hashable {
    case home
    case snap
    case favorite

    var title: String {
        switch self {
        case .home: "ホーム"
        case .snap: "コーデ"
        case .favorite: "お気に入り"
        }
    }

    var systemImageName: String {
        switch self {
        case .home: "house"
        case .snap: "photo.on.rectangle"
        case .favorite: "heart.fill"
        }
    }
}

struct MainTabView: View {
    // アプリ下部のタブ
    @State private var selectedTab: MainTab = .home
    // コーデタブ内のタブ
    @State private var selectedSnapTab: CoordinateViewTab = .product

    @StateObject private var snapRouter = RoutingState()
    @StateObject private var favoriteRouter = RoutingState()
    @StateObject private var alertState = AlertState.shared

    var rootCoordinateScreenID = UUID().uuidString

    var rootStaffScreenID = UUID().uuidString

    var rootProductScreenID = UUID().uuidString

    var rootFavoriteCoordinateScreenID = UUID().uuidString

    var rootFavoriteStaffScreenID = UUID().uuidString

    var brandCoordinateScreenID = UUID().uuidString

    var brandStaffScreenID = UUID().uuidString

    var body: some View {
        HeaderView()

        TabView(selection: $selectedTab) {
            HomeView(
                selectedTab: $selectedTab,
                selectedSnapTab: $selectedSnapTab,
                labelID: 00000, // ここは適宜変更してください
                snapRouter: snapRouter,
                brandCoordinateScreenID: brandCoordinateScreenID,
                brandStaffScreenID: brandStaffScreenID
            )
            .tabItem {
                Label(MainTab.home.title, systemImage: MainTab.home.systemImageName)
            }
            .tag(MainTab.home)

            CoordinateView(
                selectedSnapTab: $selectedSnapTab,
                router: snapRouter,
                favoriteRouter: favoriteRouter,
                coordinateScreenID: rootCoordinateScreenID,
                staffScreenID: rootStaffScreenID,
                productScreenID: rootProductScreenID,
                isFavorite: false
            )
            .tabItem {
                Label(MainTab.snap.title, systemImage: MainTab.snap.systemImageName)
            }
            .tag(MainTab.snap)

            CoordinateView(
                selectedSnapTab: $selectedSnapTab,
                router: snapRouter,
                favoriteRouter: favoriteRouter,
                coordinateScreenID: rootCoordinateScreenID,
                staffScreenID: rootStaffScreenID,
                productScreenID: rootProductScreenID,
                isFavorite: true
            )
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
