//
//  Tracker.swift
//  Example
//
//  Created by ohayoukenchan on 2025/03/18.
//  Copyright © 2025 VANISH STANDARD. All rights reserved.
//
import StaffStart__Core
import StaffStart__Tracking

@MainActor
@available(*, deprecated, message: "Tracker is deprecated, please use StaffStartTracking.trackPageView(with: ) instead")
final class Tracker {
    static let shared = Tracker()

    private init() {}

    func trackPageView(with cid: Int) async {
        do {
            try await StaffStartTracking.trackPageView(with: TrackingPageViewParams(
                contentID: cid,
                userID: nil,
                contentType: .coordinate
            ))
        } catch {
            print(error)
        }
    }
}
