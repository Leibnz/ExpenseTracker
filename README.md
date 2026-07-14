# ExpenseTracker

A SwiftUI expense tracking app built to practice architecture and testing patterns used by modern iOS teams (MVVM + Clean Architecture, protocol-based repositories, TDD).

## Why this project

I built this to go beyond tutorials and practice the patterns real product teams use: a framework-agnostic domain layer, dependency injection, and unit-tested business logic. The goal was to write code I'd be comfortable explaining and defending in a technical interview, not just code that compiles.

## Features

- Add, edit, and delete expenses (amount, category, date, note)
- Monthly spending total with budget progress
- Expense list grouped by date or category
- Local persistence with Core Data
- (Planned) Spending charts with Swift Charts
- (Planned) Search and filtering

## Architecture

The project follows **MVVM + Clean Architecture**, split into layers with a strict dependency direction: `Features` depend on `Domain`, and `Data` implements `Domain`'s protocols — never the other way around.

```
ExpenseTracker/
├── App/                    # App entry point, dependency injection
├── Core/
│   ├── Networking/
│   ├── Persistence/        # Core Data stack
│   └── Extensions/
├── Domain/
│   ├── Models/             # Plain Swift structs — no framework imports
│   ├── UseCases/           # Business logic, protocol-based
│   └── Repositories/       # Protocols only (interfaces)
├── Data/
│   └── Repositories/       # Concrete implementations (e.g. Core Data)
├── Features/
│   ├── ExpenseList/
│   │   ├── View/
│   │   ├── ViewModel/
│   │   └── Model/
│   ├── AddExpense/
│   └── Settings/
└── Resources/

ExpenseTrackerTests/
├── ViewModelTests/
├── UseCaseTests/
└── RepositoryTests/
```

### Why this structure:

- **Domain has zero framework dependencies.** No `import CoreData`, no `import SwiftUI`. Business logic (e.g. calculating monthly spend) is pure Swift, which makes it trivial to unit test and easy to reason about.
- **Repositories are protocols in Domain, implementations in Data.** `ExpenseRepositoryProtocol` is defined once and implemented by `CoreDataExpenseRepository`. This means the persistence layer (Core Data, or later Realm/CloudKit) can change without touching a single ViewModel.
- **ViewModels depend on protocols, not concrete types**, so tests use a `MockExpenseRepository` instead of hitting a real database.

## Tech stack

- SwiftUI
- Combine / async-await
- Core Data
- XCTest

## Getting started

**Requirements:** Xcode 16+, iOS 17+

```bash
git clone https://github.com/Leibnz/ExpenseTracker.git
cd ExpenseTracker
open ExpenseTracker.xcodeproj
```

Build and run on the iOS Simulator (`Cmd+R`).

## Running tests

```bash
Cmd+U
```

or via command line:

```bash
xcodebuild test -scheme ExpenseTracker -destination 'platform=iOS Simulator,name=iPhone 15'
```

Tests currently cover:
- ViewModels (using mocked repositories)
- Use cases (pure business logic)

## Decisions & trade-offs

- **Core Data over Realm**: chose Apple's native persistence framework to build depth with tools directly supported by the platform.
- **Protocol-based repositories**: adds a small amount of boilerplate up front, but makes the codebase testable and swappable — a trade-off I consider worth it for anything beyond a throwaway prototype.

## Roadmap

- [ ] Swift Charts integration for category/time breakdowns
- [ ] Search and filter
- [ ] Multi-currency support
- [ ] iCloud sync via CloudKit
- [ ] Home screen widget for monthly spend

## License

MIT
