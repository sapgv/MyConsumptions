//
//  CatalogStateIncomeListView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 02.04.2024.
//

import SwiftUI

struct CatalogStateIncomeListView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\CDCatalogStateIncome.name)]) private var list: FetchedResults<CDCatalogStateIncome>
    
    var body: some View {
        
        List(list) { cdCatalogStateIncome in
            
            Text(cdCatalogStateIncome.name ?? "")
            
            
        }
        .toolbar {
            ToolbarItem {
                NavigationLink(value: Coordinator.CatalogStateIncomeListView.new) {
                    Text("Добавить")
                }
            }
        }
        .navigationTitle(ObjectType.catalogStateIncome.title)
        .navigationDestination(for: Coordinator.CatalogStateIncomeListView.self, destination: { route in
            
            switch route {
            case .new:
                let viewModel = CatalogStateIncomeEditViewModel()
                CatalogStateIncomeEditView(viewModel: viewModel)
            case let .cdCatalogStateIncome(objectID):
                let viewModel = CatalogStateIncomeEditViewModel(id: objectID)
                CatalogStateIncomeEditView(viewModel: viewModel)
            }
            
        })
        
    }
    
}

#Preview {
    CatalogStateIncomeListView()
}
