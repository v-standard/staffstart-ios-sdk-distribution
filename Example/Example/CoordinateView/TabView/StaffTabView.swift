//
//  StaffTabView.swift
//  Example
//
//  Created by ohayoukenchan on 2025/03/14.
//  Copyright © 2025 VANISH STANDARD. All rights reserved.
//
import StaffStart__App
import StaffStart__Core
import StaffStart__Tracking
import SwiftUI

struct StaffTabView: View {
    @Binding var path: NavigationPath

    var staffListView: StaffStartStaffListView
    var onTapProduct: (_ baseProductCode: String) -> Void

    var body: some View {
        NavigationStack(path: $path) {
            staffListView
                .navigationDestination(for: Destination.self) { destination in
                    destinationView(for: destination)
                }
        }
    }
}

// MARK: - Destination Builders

private extension StaffTabView {
    @ViewBuilder
    func destinationView(for destination: Destination) -> some View {
        switch destination {
        case let .snapPlayDetail(cid):
            snapPlayDetailView(cid: cid)

        case let .snapPlayList(params, screenID):
            snapPlayListView(params: params, screenID: screenID)

        case let .staffList(params, screenID):
            staffListView(params: params, screenID: screenID)

        case let .staffDetail(id):
            staffDetailView(userID: id)
        }
    }

    @ViewBuilder
    func snapPlayDetailView(cid: Int) -> some View {
        StaffStartSnapPlayDetailView(
            cid: cid,
            onTapProduct: { onTapProduct($0) },
            onTapTag: { tag in
                path.append(
                    Destination.snapPlayList(
                        params: CoordinateListParams(tags: [tag]),
                        screenID: UUID().uuidString
                    )
                )
            },
            onTapStaff: { userID in
                path.append(Destination.staffDetail(id: userID))
            },
            onTapSnapPlay: { cid in
                handleTapSnapPlay(cid)
            },
            onTapReadMore: { params in
                path.append(
                    Destination.snapPlayList(
                        params: params,
                        screenID: UUID().uuidString
                    )
                )
            },
            onFavoriteFailed: { error in
                handleError(error)
            }
        )
    }

    @ViewBuilder
    func snapPlayListView(params: CoordinateListParams, screenID: String) -> some View {
        StaffStartSnapPlayListView(
            screenID: screenID,
            coordinateListParams: params,
            onTapSnapPlay: { cid in
                handleTapSnapPlay(cid)
            },
            onFavoriteFailed: { error in
                handleError(error)
            }
        )
        .toolbarRole(.editor)
    }

    @ViewBuilder
    func staffListView(params: StaffListParams, screenID: String) -> some View {
        StaffStartStaffListView(
            screenID: screenID,
            staffListParams: params,
            onTapStaff: { userID in
                path.append(Destination.staffDetail(id: userID))
            },
            onFavoriteFailed: { error in
                handleError(error)
            }
        )
        .toolbarRole(.editor)
    }

    @ViewBuilder
    func staffDetailView(userID: Int) -> some View {
        StaffStartStaffDetailView(
            userID: userID,
            onTapSnapPlay: { cid in
                handleTapSnapPlay(cid)
            },
            onTapReadMore: { params in
                path.append(
                    Destination.snapPlayList(
                        params: params,
                        screenID: UUID().uuidString
                    )
                )
            },
            onFavoriteFailed: { error in
                handleError(error)
            }
        )
    }
}

// MARK: - Actions（共通化）

private extension StaffTabView {
    func handleTapSnapPlay(_ cid: Int) {
        path.append(Destination.snapPlayDetail(cid: cid))
        Task {
            await trackSnapPlayPageView(cid: cid)
        }
    }

    func trackSnapPlayPageView(cid: Int) async {
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
}
