//
//  CatalogStateIncomeListView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 02.04.2024.
//

import SwiftUI

struct CatalogStateIncomeListView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var list: FetchedResults<CDCatalogStateIncome>
    
    var body: some View {
        
        List(list) { cdCatalogStateIncome in
            
            NavigationLink(value: Coordinator.CatalogStateIncomeListView.edit(objectID: cdCatalogStateIncome.objectID)) {
                Text(cdCatalogStateIncome.name ?? "")
            }
            
        }
        .toolbar {
            ToolbarItem {
                NavigationLink(value: Coordinator.CatalogStateIncomeListView.new) {
                    Text("Добавить")
                }
            }
        }
        .navigationTitle(ObjectType.catalogStateIncome.listTitle)
        .navigationDestination(for: Coordinator.CatalogStateIncomeListView.self, destination: { route in
            
            switch route {
            case .new:
                let viewModel = CatalogStateIncomeEditViewModel()
                CatalogStateIncomeEditView(viewModel: viewModel)
            case let .edit(objectID):
                let viewModel = CatalogStateIncomeEditViewModel(id: objectID)
                CatalogStateIncomeEditView(viewModel: viewModel)
            }
            
        })
        
    }
    
}

#Preview {
    CatalogStateIncomeListView()
}
