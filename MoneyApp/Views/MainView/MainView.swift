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
                        Text(ObjectType.catalogStateIncome.listTitle)
                    }
                    
                    NavigationLink(value: Coordinator.MainView.catalogStateConsumption) {
                        Text(ObjectType.catalogStateConsumption.listTitle)
                    }
                    
                    NavigationLink(value: Coordinator.MainView.catalogContact) {
                        Text(ObjectType.catalogContact.listTitle)
                    }
                    
                    NavigationLink(value: Coordinator.MainView.catalogDebt) {
                        Text(ObjectType.catalogDebt.listTitle)
                    }
                    
                    NavigationLink(value: Coordinator.MainView.catalogWallet) {
                        Text(ObjectType.catalogWallet.listTitle)
                    }
                    
                    
                } header: {
                    Text("Справочники")
                }

            }
            .navigationTitle("Main")
            .navigationDestination(for: Coordinator.MainView.self) { route in
                
                switch route {
                case .catalogStateIncome:
                    CatalogCommonListView<CDCatalogStateIncome>(objectType: ObjectType.catalogStateIncome)
                case .catalogStateConsumption:
                    CatalogCommonListView<CDCatalogStateConsumption>(objectType: ObjectType.catalogStateConsumption)
                case .catalogContact:
                    CatalogCommonListView<CDCatalogContact>(objectType: ObjectType.catalogContact)
                case .catalogDebt:
                    CatalogCommonListView<CDCatalogDebt>(objectType: ObjectType.catalogDebt)
                case .catalogWallet:
                    CatalogCommonListView<CDCatalogWallet>(objectType: ObjectType.catalogWallet)
                }
                
            }
            
            
        }
        
        
    }
}

#Preview {
    MainView()
}
