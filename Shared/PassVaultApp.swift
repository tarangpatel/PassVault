//
//  PassVaultApp.swift
//  Shared
//
//  Created by Tarang Patel on 2021-08-11.
//

import SwiftUI

@main
struct PassVaultApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
