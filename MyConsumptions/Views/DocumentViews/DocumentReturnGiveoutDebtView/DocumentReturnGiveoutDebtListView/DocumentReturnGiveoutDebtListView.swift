//
//  DocumentReturnGiveoutDebtListView.swift
//  MyConsumptions
//
//  Created by Grigory Sapogov on 19.10.2024.
//

import SwiftUI

struct DocumentReturnGiveoutDebtListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CDDocumentReturnGiveoutDebt.date, ascending: false)]) private var list: FetchedResults<CDDocumentReturnGiveoutDebt>

    var objectType: ObjectType
    
    var viewModel: DocumentReturnGiveoutDebtListViewModel
    
    var body: some View {
        
        List(list) { document in
            
            NavigationLink(value: Coordinator.DocumentReturnGiveoutDebtListView.edit(objectID: document.objectID)) {
                DocumentReturnGiveoutDebtListRowView(date: document.date, contact: document.cdContact?.name, debt: document.cdDebt?.name, value: document.value?.decimalValue ?? 0, comment: document.comment)
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
                NavigationLink(value: Coordinator.DocumentReturnGiveoutDebtListView.new) {
                    Text("Добавить")
                }
            }
        }
        .navigationTitle(objectType.listTitle)
        .navigationDestination(for: Coordinator.DocumentReturnGiveoutDebtListView.self, destination: { route in

            switch route {
            case .new:
                let viewModel = DocumentReturnGiveoutDebtEditViewModel()
                DocumentReturnGiveoutDebtEditView(viewModel: viewModel, objectType: objectType)
            case let .edit(objectID):
                let viewModel = DocumentReturnGiveoutDebtEditViewModel(id: objectID)
                DocumentReturnGiveoutDebtEditView(viewModel: viewModel, objectType: objectType)
            }
            
        })
        
    }
    
}

#Preview {
    DocumentReturnGiveoutDebtListView(objectType: .documentReturnGiveoutDebt, viewModel: DocumentReturnGiveoutDebtListViewModel())
}
