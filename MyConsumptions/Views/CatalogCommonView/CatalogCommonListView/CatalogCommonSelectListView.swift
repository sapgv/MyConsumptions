//
//  CatalogCommonSelectListView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import SwiftUI
import CoreData

struct CatalogCommonSelectListView<T: CDCatalogName>: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var coordinator: Coordinator
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: T.sortKey, ascending: true)]) private var list: FetchedResults<T>

    var objectType: ObjectType
    
    var selected: T?
    
    var selectAction: ((T) -> Void)
    
    var body: some View {
        
        List(list) { catalog in
            
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
                self.selectAction(catalog)
                dismiss()
            }
            
        }
        .toolbar {
            ToolbarItem {
                NavigationLink(value: Coordinator.CatalogCommonSelectListView.new) {
                    Text("Добавить")
                }
            }
        }
        .navigationTitle(objectType.listTitle)
        .navigationDestination(for: Coordinator.CatalogCommonSelectListView.self, destination: { route in
            switch route {
            case .new:
                let viewModel = CatalogCommonEditViewModel<T>()
                CatalogCommonEditView(viewModel: viewModel, objectType: objectType)
                    .environmentObject(coordinator)
                    
            }
        })
        
    }
    
}

#Preview {
    CatalogCommonSelectListView<CDCatalogStateIncome>(objectType: ObjectType.catalogStateIncome, selectAction: { _ in })
}
