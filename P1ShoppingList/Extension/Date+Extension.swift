//
//  Date+Extension.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/06.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation

extension Date {
    
    // MARK: - Computed Properties
    /// 月
    var month: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter.string(from: self)
    }
    
    /// 日
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    
}
