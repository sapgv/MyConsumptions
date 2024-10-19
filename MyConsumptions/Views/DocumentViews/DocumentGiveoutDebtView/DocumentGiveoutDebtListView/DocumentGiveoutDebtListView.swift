//
//  DocumentGiveoutDebtListView.swift
//  MyConsumptions
//
//  Created by Grigory Sapogov on 19.10.2024.
//

import SwiftUI

struct DocumentGiveoutDebtListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CDDocumentGiveoutDebt.date, ascending: false)]) private var list: FetchedResults<CDDocumentGiveoutDebt>

    var objectType: ObjectType
    
    var viewModel: DocumentGiveoutDebtListViewModel
    
    var body: some View {
        
        List(list) { document in
            
            NavigationLink(value: Coordinator.DocumentGiveoutDebtListView.edit(objectID: document.objectID)) {
                DocumentGiveoutDebtListRowView(date: document.date, contact: document.cdContact?.name, debt: document.cdDebt?.name, value: document.value?.decimalValue ?? 0, comment: document.comment)
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
                NavigationLink(value: Coordinator.DocumentGiveoutDebtListView.new) {
                    Text("Добавить")
                }
            }
        }
        .navigationTitle(objectType.listTitle)
        .navigationDestination(for: Coordinator.DocumentGiveoutDebtListView.self, destination: { route in

            switch route {
            case .new:
                let viewModel = DocumentGiveoutDebtEditViewModel()
                DocumentGiveoutDebtEditView(viewModel: viewModel, objectType: objectType)
            case let .edit(objectID):
                let viewModel = DocumentGiveoutDebtEditViewModel(id: objectID)
                DocumentGiveoutDebtEditView(viewModel: viewModel, objectType: objectType)
            }
            
        })
        
    }
    
}

#Preview {
    DocumentGiveoutDebtListView(objectType: .documentGiveoutDebt, viewModel: DocumentGiveoutDebtListViewModel())
}
