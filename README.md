# ExpenseTracker

A SwiftUI expense tracking app built to practice architecture and testing patterns used by modern iOS teams (MVVM + Clean Architecture, protocol-based repositories, TDD).

### Why this project

I built this to go beyond tutorials and practice the patterns real product teams use: a framework-agnostic domain layer, dependency injection, and unit-tested business logic. The goal was to write code I'd be comfortable explaining and defending in a technical interview, not just code that compiles.

### Features

Add, edit, and delete expenses (amount, category, date, note)
Monthly spending total with budget progress
Expense list grouped by date or category
Local persistence with Core Data
(Planned) Spending charts with Swift Charts
(Planned) Search and filtering

### Architecture

The project follows MVVM + Clean Architecture, split into layers with a strict dependency direction: Features depend on Domain, and Data implements Domain's protocols - never the other way around.

### Why this structure:

Domain has zero framework dependencies. No import CoreData, no import SwiftUI. Business logic (e.g. calculating monthly spend) is pure Swift, which makes it trivial to unit test and easy to reason about.
Repositories are protocols in Domain, implementations in Data. ExpenseRepositoryProtocol is defined once and implemented by CoreDataExpenseRepository. This means the persistence layer (Core Data, or later Realm/CloudKit) can change without touching a single ViewModel.
ViewModels depend on protocols, not concrete types, so tests use a MockExpenseRepository instead of hitting a real database.

### Tech stack

SwiftUI
Combine / async-await
Core Data
XCTest

### Getting started

Requirements: Xcode 16+, iOS 17+

### Decisions & trade-offs

Core Data over Realm: chose Apple's native persistence framework to build depth with tools directly supported by the platform.
Protocol-based repositories: adds a small amount of boilerplate up front, but makes the codebase testable and swappable — a trade-off I consider worth it for anything beyond a throwaway prototype.
