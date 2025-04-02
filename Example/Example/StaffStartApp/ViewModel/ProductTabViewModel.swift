//
//  ProductTabViewModel.swift
//  Example
//
//  Created by ohayoukenchan on 2025/03/18.
//  Copyright © 2025 VANISH STANDARD. All rights reserved.
//
import SwiftUI

final class ProductTabViewModel: ObservableObject {
    @Published var baseProductCode: String?

    func updateBaseProductCode(_ baseProductCode: String) {
        self.baseProductCode = baseProductCode
    }
}
