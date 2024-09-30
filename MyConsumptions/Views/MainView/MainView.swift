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
                    
                    NavigationLink(value: Coordinator.MainView.documentIncome) {
                        Text(ObjectType.documentIncome.listTitle)
                    }
                    
                    NavigationLink(value: Coordinator.MainView.documentConsumption) {
                        Text(ObjectType.documentConsumption.listTitle)
                    }
                    
                    NavigationLink(value: Coordinator.MainView.documentTransfer) {
                        Text(ObjectType.documentTransfer.listTitle)
                    }
                    
                }
                header: {
                    Text("Документы")
                }
                
                Section {
                    
                    NavigationLink(value: Coordinator.MainView.catalogStateIncome) {
                        Text(ObjectType.catalogStateIncome.listTitle)
                    }
                    
                    NavigationLink(value: Coordinator.MainView.catalogStateConsumption) {
                        Text(ObjectType.catalogStateConsumption.listTitle)
                    }
                    
//                    NavigationLink(value: Coordinator.MainView.catalogContact) {
//                        Text(ObjectType.catalogContact.listTitle)
//                    }
                    
//                    NavigationLink(value: Coordinator.MainView.catalogDebt) {
//                        Text(ObjectType.catalogDebt.listTitle)
//                    }
                    
                    NavigationLink(value: Coordinator.MainView.catalogWallet) {
                        Text(ObjectType.catalogWallet.listTitle)
                    }
                    
                    
                } header: {
                    Text("Справочники")
                }

            }
            .navigationTitle("Операции")
            .navigationDestination(for: Coordinator.MainView.self) { route in
                
                switch route {
                case .documentIncome:
                    DocumentIncomeListView(objectType: .documentIncome)
                case .documentConsumption:
                    DocumentConsumptionListView(objectType: .documentConsumption)
                case .documentTransfer:
                    DocumentTransferListView(objectType: .documentTransfer)
                case .catalogStateIncome:
                    CatalogCommonListView<CDCatalogStateIncome>(objectType: .catalogStateIncome)
                case .catalogStateConsumption:
                    CatalogCommonListView<CDCatalogStateConsumption>(objectType: .catalogStateConsumption)
                case .catalogContact:
                    CatalogCommonListView<CDCatalogContact>(objectType: .catalogContact)
                case .catalogDebt:
                    CatalogCommonListView<CDCatalogDebt>(objectType: .catalogDebt)
                case .catalogWallet:
                    CatalogCommonListView<CDCatalogWallet>(objectType: .catalogWallet)
                }
                
            }
            
            
        }
        
        
    }
}

#Preview {
    MainView()
}
