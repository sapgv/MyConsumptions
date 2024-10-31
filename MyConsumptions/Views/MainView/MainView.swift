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
                    
                    ScrollView(.horizontal) {
                                LazyHStack {
                                    ForEach(0..<10) { i in
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color(hue: Double(1) / 10, saturation: 1, brightness: 1).gradient)
//                                            .frame(width: 300, height: 200)
//                                            .frame(height: 200)
//                                            .frame(minWidth: 200)
                                            .frame(width: UIScreen.main.bounds.width - 100, height: 200)
                                    }
                                }
                                .scrollTargetLayout()
                            }
                            .scrollTargetBehavior(.viewAligned)
                            .contentMargins(20, for: .scrollContent) // Add padding
//                            .safeAreaPadding(.horizontal, 40)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .listRowBackground(Color.clear)
                            .scrollIndicators(.never)
                }
                
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
                    
                    NavigationLink(value: Coordinator.MainView.documentGiveoutDebt) {
                        Text(ObjectType.documentGiveoutDebt.listTitle)
                    }
                    
                    NavigationLink(value: Coordinator.MainView.documentReturnGiveoutDebt) {
                        Text(ObjectType.documentReturnGiveoutDebt.listTitle)
                    }
                    
                    NavigationLink(value: Coordinator.MainView.documentTakenDebt) {
                        Text(ObjectType.documentTakenDebt.listTitle)
                    }
                    
                    NavigationLink(value: Coordinator.MainView.documentReturnTakenDebt) {
                        Text(ObjectType.documentReturnTakenDebt.listTitle)
                    }
                    
                }
                header: {
                    Text("Долги")
                }
                
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
            .navigationTitle("Операции")
            .navigationDestination(for: Coordinator.MainView.self) { route in
                
                switch route {
                case .documentIncome:
                    DocumentIncomeListView(objectType: .documentIncome, viewModel: DocumentIncomeListViewModel())
                case .documentConsumption:
                    DocumentConsumptionListView(objectType: .documentConsumption, viewModel: DocumentConsumptionListViewModel())
                case .documentTransfer:
                    DocumentTransferListView(objectType: .documentTransfer, viewModel: DocumentTransferListViewModel())
                case .documentGiveoutDebt:
                    DocumentGiveoutDebtListView(objectType: .documentGiveoutDebt, viewModel: DocumentGiveoutDebtListViewModel())
                case .documentReturnGiveoutDebt:
                    DocumentReturnGiveoutDebtListView(objectType: .documentReturnGiveoutDebt, viewModel: DocumentReturnGiveoutDebtListViewModel())
                case .documentTakenDebt:
                    DocumentTakenDebtListView(objectType: .documentTakenDebt, viewModel: DocumentTakenDebtListViewModel())
                case .documentReturnTakenDebt:
                    DocumentReturnTakenDebtListView(objectType: .documentReturnTakenDebt, viewModel: DocumentReturnTakenDebtListViewModel())
                case .catalogStateIncome:
                    CatalogCommonListView<CDCatalogStateIncome>(objectType: .catalogStateIncome, viewModel: CatalogCommonListViewModel<CDCatalogStateIncome>())
                case .catalogStateConsumption:
                    CatalogCommonListView<CDCatalogStateConsumption>(objectType: .catalogStateConsumption, viewModel: CatalogCommonListViewModel<CDCatalogStateConsumption>())
                case .catalogContact:
                    CatalogCommonListView<CDCatalogContact>(objectType: .catalogContact, viewModel: CatalogCommonListViewModel<CDCatalogContact>())
                case .catalogDebt:
                    CatalogCommonListView<CDCatalogDebt>(objectType: .catalogDebt, viewModel: CatalogCommonListViewModel<CDCatalogDebt>())
                case .catalogWallet:
                    CatalogCommonListView<CDCatalogWallet>(objectType: .catalogWallet, viewModel: CatalogCommonListViewModel<CDCatalogWallet>())
                }
                
            }
            
            
        }
        
        
    }
}

#Preview {
    MainView()
        .environmentObject(Coordinator())
}
