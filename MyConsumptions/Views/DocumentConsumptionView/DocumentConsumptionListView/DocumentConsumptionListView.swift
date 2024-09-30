//
//  DocumentConsumptionListView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 30.09.2024.
//

import SwiftUI

struct DocumentConsumptionListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CDDocumentConsumption.date, ascending: false)]) private var list: FetchedResults<CDDocumentConsumption>

    var objectType: ObjectType
    
    var body: some View {
        
        List(list) { document in
            
            NavigationLink(value: Coordinator.DocumentConsumptionListView.edit(objectID: document.objectID)) {
                DocumentConsumptionListRowView(date: document.date, wallet: document.cdCatalogWallet?.name, value: document.value, stateComment: document.stateComment, comment: document.comment)
            }
            
        }
        .toolbar {
            ToolbarItem {
                NavigationLink(value: Coordinator.DocumentConsumptionListView.new) {
                    Text("Добавить")
                }
            }
        }
        .navigationTitle(objectType.listTitle)
        .navigationDestination(for: Coordinator.DocumentConsumptionListView.self, destination: { route in
            
            switch route {
            case .new:
                let viewModel = DocumentConsumptionEditViewModel()
                DocumentConsumptionEditView(viewModel: viewModel, objectType: objectType)
            case let .edit(objectID):
                let viewModel = DocumentConsumptionEditViewModel(id: objectID)
                DocumentConsumptionEditView(viewModel: viewModel, objectType: objectType)
            }
            
        })
        
    }
    
}

#Preview {
    DocumentConsumptionListView(objectType: .documentConsumption)
}
