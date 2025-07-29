//
//  _01__FileRSApp.swift
//  (01) FileRS
//
//  Created by Daniel Petrean on 13.07.25.
//

import SwiftUI

@main
struct _01__FileRSApp: App {
    @StateObject private var companyStore = CompanyStore() // Create the store

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(companyStore) // Inject it here
        }
    }
}
