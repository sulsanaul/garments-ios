//
//  GarmentsApp.swift
//  Garments
//
//  Created by Sul S. on 5/11/23.
//

import SwiftUI

@main
struct GarmentsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            GarmentListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

