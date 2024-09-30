//
//  DocumentTransferListView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 30.09.2024.
//

import SwiftUI

struct DocumentTransferListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CDDocumentTransfer.date, ascending: false)]) private var list: FetchedResults<CDDocumentTransfer>

    var objectType: ObjectType
    
    var body: some View {
        
        List(list) { document in
            
            NavigationLink(value: Coordinator.DocumentTransferListView.edit(objectID: document.objectID)) {
                DocumentTransferListRowView(date: document.date, walletFrom: document.cdCatalogWalletFrom?.name, walletTo: document.cdCatalogWalletTo?.name, value: document.value?.decimalValue ?? 0, comment: document.comment)
            }
            
        }
        .toolbar {
            ToolbarItem {
                NavigationLink(value: Coordinator.DocumentTransferListView.new) {
                    Text("Добавить")
                }
            }
        }
        .navigationTitle(objectType.listTitle)
        .navigationDestination(for: Coordinator.DocumentTransferListView.self, destination: { route in
            
            switch route {
            case .new:
                let viewModel = DocumentTransferEditViewModel()
                DocumentTransferEditView(viewModel: viewModel, objectType: objectType)
            case let .edit(objectID):
                let viewModel = DocumentTransferEditViewModel(id: objectID)
                DocumentTransferEditView(viewModel: viewModel, objectType: objectType)
            }
            
        })
        
    }
    
}

#Preview {
    DocumentTransferListView(objectType: .documentTransfer)
}
