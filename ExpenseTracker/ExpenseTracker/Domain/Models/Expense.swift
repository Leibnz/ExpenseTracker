//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Andrew on 15.07.2026.
//

import Foundation

struct Expense: Identifiable, Equatable {
    let id: UUID
    var amount: Double
    var category: ExpenseCategory
    var date: Date
    var note: String?
}

enum ExpenseCategory: String, CaseIterable, Codable {
    case food, transport, housing, entertainment, health, other
}
