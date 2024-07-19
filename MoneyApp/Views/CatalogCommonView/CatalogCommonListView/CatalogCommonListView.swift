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
    
    var selected: T?
    
    var selectAction: ((T) -> Void)?
    
    var body: some View {
        
        List(list) { catalog in
            
            if let selectAction = selectAction {
                
                HStack {
                    Text(catalog.name ?? "")
                        .contentShape(Rectangle())
                        .onTapGesture {
                            dismiss()
                            selectAction(catalog)
                        }
                    Spacer()
                    if catalog.name == selected?.name {
                        Image(systemName: "checkmark")
                            .foregroundStyle(Color.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectAction?(catalog)
                    dismiss()
                }
                
                
            }
            else {
                NavigationLink(value: Coordinator.CatalogCommonListView.edit(objectID: catalog.objectID)) {
                    Text(catalog.name ?? "")
                }
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
    CatalogCommonListView<CDCatalogStateIncome>(objectType: ObjectType.catalogStateIncome)
}
