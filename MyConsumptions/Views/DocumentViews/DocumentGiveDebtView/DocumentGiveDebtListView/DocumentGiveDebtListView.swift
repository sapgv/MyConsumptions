//
//  DocumentGiveDebtListView.swift
//  MyConsumptions
//
//  Created by Grigory Sapogov on 19.10.2024.
//

import SwiftUI

struct DocumentGiveDebtListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CDDocumentGiveDebt.date, ascending: false)]) private var list: FetchedResults<CDDocumentGiveDebt>

    var objectType: ObjectType
    
    var viewModel: DocumentGiveDebtListViewModel
    
    var body: some View {
        
        List(list) { document in
            
            NavigationLink(value: Coordinator.DocumentGiveDebtListView.edit(objectID: document.objectID)) {
                DocumentGiveDebtListRowView(date: document.date, contact: document.cdContact?.name, debt: document.cdDebt?.name, value: document.value?.decimalValue ?? 0, comment: document.comment)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button("Удалить") {
                    withAnimation {
                        self.viewModel.delete(cdDocument: document)
                    }
                }
                .tint(.red)
            }
            
        }
        .toolbar {
            ToolbarItem {
                NavigationLink(value: Coordinator.DocumentGiveDebtListView.new) {
                    Text("Добавить")
                }
            }
        }
        .navigationTitle(objectType.listTitle)
        .navigationDestination(for: Coordinator.DocumentGiveDebtListView.self, destination: { route in

            switch route {
            case .new:
                let viewModel = DocumentGiveDebtEditViewModel()
                DocumentGiveDebtEditView(viewModel: viewModel, objectType: objectType)
            case let .edit(objectID):
                let viewModel = DocumentGiveDebtEditViewModel(id: objectID)
                DocumentGiveDebtEditView(viewModel: viewModel, objectType: objectType)
            }
            
        })
        
    }
    
}

#Preview {
    DocumentGiveDebtListView(objectType: .documentGiveDebt, viewModel: DocumentGiveDebtListViewModel())
}
