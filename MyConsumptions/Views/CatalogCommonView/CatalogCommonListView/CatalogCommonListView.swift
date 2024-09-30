//
//  CatalogCommonListView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 15.07.2024.
//

import SwiftUI
import CoreData

struct CatalogCommonListView<T: CDCatalogName>: View {
    
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: T.sortKey, ascending: true)]) private var list: FetchedResults<T>

    var objectType: ObjectType
    
    var viewModel: CatalogCommonListViewModel<T>
    
    var body: some View {
        
        List(list) { catalog in
            
            NavigationLink(value: Coordinator.CatalogCommonListView.edit(objectID: catalog.objectID)) {
                Text(catalog.name ?? "")
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button("Удалить") {
                    withAnimation {
                        self.viewModel.delete(cdCatalog: catalog)
                    }
                }
                .tint(.red)
            }
            
        }
        .toolbar {
            ToolbarItem {
                NavigationLink(value: Coordinator.CatalogCommonListView.new) {
                    Text("Добавить")
                }
            }
        }
        .navigationTitle(objectType.listTitle)
        .navigationDestination(for: Coordinator.CatalogCommonListView.self, destination: { route in
            
            switch route {
            case .new:
                if objectType == .catalogDebt {
                    let viewModel = CatalogDebtEditViewModel()
                    CatalogDebtEditView(viewModel: viewModel, objectType: objectType)
                }
                else {
                    let viewModel = CatalogCommonEditViewModel<T>()
                    CatalogCommonEditView(viewModel: viewModel, objectType: objectType)
                }
                
            case let .edit(objectID):
                if objectType == .catalogDebt {
                    let viewModel = CatalogDebtEditViewModel(id: objectID)
                    CatalogDebtEditView(viewModel: viewModel, objectType: objectType)
                }
                else {
                    let viewModel = CatalogCommonEditViewModel<T>(id: objectID)
                    CatalogCommonEditView(viewModel: viewModel, objectType: objectType)
                }
            }
            
        })
        
        
    }
    
}

#Preview {
    CatalogCommonListView<CDCatalogStateIncome>(objectType: ObjectType.catalogStateIncome, viewModel: CatalogCommonListViewModel<CDCatalogStateIncome>())
}
