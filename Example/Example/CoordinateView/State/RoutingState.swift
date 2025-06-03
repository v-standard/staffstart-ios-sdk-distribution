//
//  RoutingState.swift
//  Example
//
//  Created by ohayoukenchan on 2025/03/14.
//  Copyright © 2025 VANISH STANDARD. All rights reserved.
//

import StaffStart__Core
import StaffStart__Tracking
import SwiftUI

@MainActor
public final class RoutingState: ObservableObject {
    /// コーディネートのタブの中で遷移させるパス
    @Published public var snapPlayListPath = NavigationPath()

    /// スタッフのタブの中で遷移させるパス
    @Published public var staffListPath = NavigationPath()
}
