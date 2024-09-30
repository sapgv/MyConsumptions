//
//  MoneyAppApp.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 02.04.2024.
//

import SwiftUI

@main
struct MoneyAppApp: App {
    
    @StateObject private var coordinator: Coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, Model.coreData.viewContext)
                .environmentObject(self.coordinator)
        }
    }
}
