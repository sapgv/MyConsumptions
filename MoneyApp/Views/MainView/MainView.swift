//
//  ContentView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 02.04.2024.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        
        NavigationStack(path: $coordinator.path) {
            
            List {
                
                Section {
                    
                    NavigationLink(value: Coordinator.MainView.catalogStateIncome) {
                        Text(ObjectType.catalogStateIncome.title)
                    }
                    
                    
                } header: {
                    Text("Справочники")
                }

            }
            .navigationTitle("Main")
            .navigationDestination(for: Coordinator.MainView.self) { route in
                
                switch route {
                case .catalogStateIncome:
                    CatalogCommonListView<CDCatalogStateIncome>(title: ObjectType.catalogStateIncome.title)
                }
                
            }
            
            
        }
        
        
    }
}

#Preview {
    MainView()
}
