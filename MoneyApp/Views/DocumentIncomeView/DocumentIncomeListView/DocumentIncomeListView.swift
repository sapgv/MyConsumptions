//
//  DocumentIncomeListView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import SwiftUI

struct DocumentIncomeListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CDDocumentIncome.date, ascending: false)]) private var list: FetchedResults<CDDocumentIncome>

    var objectType: ObjectType
    
    var body: some View {
        
        List(list) { document in
            
            NavigationLink(value: Coordinator.DocumentIncomeListView.edit(objectID: document.objectID)) {
                DocumentIncomeListRowView(date: document.date, wallet: document.cdCatalogWallet?.name, value: document.value, stateComment: document.stateComment, comment: document.comment)
            }
            
        }
        .toolbar {
            ToolbarItem {
                NavigationLink(value: Coordinator.DocumentIncomeListView.new) {
                    Text("Добавить")
                }
            }
        }
        .navigationTitle(objectType.listTitle)
        .navigationDestination(for: Coordinator.DocumentIncomeListView.self, destination: { route in
            
            switch route {
            case .new:
                let viewModel = DocumentIncomeEditViewModel()
                DocumentIncomeEditView(viewModel: viewModel, objectType: objectType)
            case let .edit(objectID):
                let viewModel = DocumentIncomeEditViewModel(id: objectID)
                DocumentIncomeEditView(viewModel: viewModel, objectType: objectType)
            }
            
        })
        
        
    }
    
}

#Preview {
    DocumentIncomeListView(objectType: .documentIncome)
}
