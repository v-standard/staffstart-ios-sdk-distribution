//
//  Destination.swift
//  Example
//
//  Created by ohayoukenchan on 2025/03/14.
//  Copyright © 2025 VANISH STANDARD. All rights reserved.
//
// 遷移先を管理する Enum
import StaffStart__Core

typealias ScreenID = String

enum Destination: Hashable {
    case snapPlayDetail(cid: Int)
    case snapPlayList(params: CoordinateListParams, screenID: ScreenID)
    case staffDetail(id: Int)
    case staffList(params: StaffListParams, screenID: ScreenID)
}
