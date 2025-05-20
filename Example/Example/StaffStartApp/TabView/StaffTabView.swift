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
                    switch destination {
                    case let .snapPlayDetail(cid):
                        StaffStartSnapPlayDetailView(
                            cid: cid,
                            onTapProduct: { onTapProduct($0) },
                            onTapTag: { tag in
                                path.append(Destination.snapPlayList(params: CoordinateListParams(
                                    tags: [tag]
                                ), screenID: UUID().uuidString))
                            },
                            onTapStaff: { userID in
                                path.append(Destination.staffDetail(id: userID))
                            },
                            onTapSnapPlay: { cid in
                                path.append(Destination.snapPlayDetail(cid: cid))
                                Task {
                                    await Tracker.shared.trackPageView(with: cid)
                                }
                            },
                            onTapReadMore: { params in
                                path.append(Destination.snapPlayList(params: params, screenID: UUID().uuidString))
                            }
                        )
                    case let .snapPlayList(params, screenID):
                        StaffStartSnapPlayListView(
                            screenID: screenID,
                            coordinateListParams: params,
                            onTapSnapPlay: { cid in
                                path.append(Destination.snapPlayDetail(cid: cid))
                                Task {
                                    await Tracker.shared.trackPageView(with: cid)
                                }
                            }
                        )
                        .toolbarRole(.editor)
                    case let .staffList(params, screenID):
                        StaffStartStaffListView(
                            screenID: screenID,
                            staffListParams: params
                        ) { userID in
                            path.append(Destination.staffDetail(id: userID))
                        }
                        .toolbarRole(.editor)
                    case let .staffDetail(id):
                        StaffStartStaffDetailView(
                            userID: id,
                            onTapSnapPlay: { cid in
                                path.append(Destination.snapPlayDetail(cid: cid))
                                Task {
                                    await Tracker.shared.trackPageView(with: cid)
                                }
                            },
                            onTapReadMore: { params in
                                path.append(Destination.snapPlayList(params: params, screenID: UUID().uuidString))
                            }
                        )
                    }
                }
        }
    }
}
