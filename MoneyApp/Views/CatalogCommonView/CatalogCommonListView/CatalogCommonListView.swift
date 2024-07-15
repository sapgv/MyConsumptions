//
//  CatalogCommonListView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 15.07.2024.
//

import SwiftUI
import CoreData

struct CatalogCommonListView<T: CDCatalogName>: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: T.sortKey, ascending: true)]) private var list: FetchedResults<T>
    
    var title: String
    
    var body: some View {
        
        List(list) { catalog in
            
            NavigationLink(value: Coordinator.CatalogCommonListView.edit(objectID: catalog.objectID)) {
                Text(catalog.name ?? "")
            }
            
        }
        .toolbar {
            ToolbarItem {
                NavigationLink(value: Coordinator.CatalogCommonListView.new) {
                    Text("Добавить")
                }
            }
        }
        .navigationTitle(title)
        .navigationDestination(for: Coordinator.CatalogCommonListView.self, destination: { route in
            
            switch route {
            case .new:
                let viewModel = CatalogCommonEditViewModel<T>()
                CatalogCommonEditView(viewModel: viewModel)
            case let .edit(objectID):
                let viewModel = CatalogCommonEditViewModel<T>(id: objectID)
                CatalogCommonEditView(viewModel: viewModel)
            }
            
        })
        
    }
    
}

#Preview {
    CatalogCommonListView<CDCatalogStateIncome>(title: ObjectType.catalogStateIncome.title)
}
