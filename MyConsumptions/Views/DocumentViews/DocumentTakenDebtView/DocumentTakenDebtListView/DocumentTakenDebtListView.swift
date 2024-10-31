//
//  DocumentTakenDebtListView.swift
//  MyConsumptions
//
//  Created by Grigory Sapogov on 31.10.2024.
//

import SwiftUI

struct DocumentTakenDebtListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CDDocumentTakenDebt.date, ascending: false)]) private var list: FetchedResults<CDDocumentTakenDebt>

    var objectType: ObjectType
    
    var viewModel: DocumentTakenDebtListViewModel
    
    var body: some View {
        
        List(list) { document in
            
            NavigationLink(value: Coordinator.DocumentTakenDebtListView.edit(objectID: document.objectID)) {
                DocumentTakenDebtListRowView(date: document.date, contact: document.cdContact?.name, debt: document.cdDebt?.name, value: document.value?.decimalValue ?? 0, comment: document.comment)
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
                NavigationLink(value: Coordinator.DocumentTakenDebtListView.new) {
                    Text("Добавить")
                }
            }
        }
        .navigationTitle(objectType.listTitle)
        .navigationDestination(for: Coordinator.DocumentTakenDebtListView.self, destination: { route in

            switch route {
            case .new:
                let viewModel = DocumentTakenDebtEditViewModel()
                DocumentTakenDebtEditView(viewModel: viewModel, objectType: objectType)
            case let .edit(objectID):
                let viewModel = DocumentTakenDebtEditViewModel(id: objectID)
                DocumentTakenDebtEditView(viewModel: viewModel, objectType: objectType)
            }
            
        })
        
    }
    
}

#Preview {
    DocumentTakenDebtListView(objectType: .documentTakenDebt, viewModel: DocumentTakenDebtListViewModel())
}
