//
//  CoordinateViewTab.swift
//  Example
//
//  Created by ohayoukenchan on 2025/07/22.
//  Copyright © 2025 VANISH STANDARD. All rights reserved.
//
enum CoordinateViewTab: String, CaseIterable, Identifiable, Sendable {
    case product
    case coordinate
    case staff

    var id: String { rawValue }

    var title: String {
        switch self {
        case .product: "商品"
        case .coordinate: "コーディネート"
        case .staff: "スタッフ"
        }
    }
}
