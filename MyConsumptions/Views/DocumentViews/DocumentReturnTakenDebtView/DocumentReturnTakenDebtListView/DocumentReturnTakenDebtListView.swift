//
//  DocumentReturnTakenDebtListView.swift
//  MyConsumptions
//
//  Created by Grigory Sapogov on 31.10.2024.
//

import SwiftUI

struct DocumentReturnTakenDebtListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CDDocumentReturnTakenDebt.date, ascending: false)]) private var list: FetchedResults<CDDocumentReturnTakenDebt>

    var objectType: ObjectType
    
    var viewModel: DocumentReturnTakenDebtListViewModel
    
    var body: some View {
        
        List(list) { document in
            
            NavigationLink(value: Coordinator.DocumentReturnTakenDebtListView.edit(objectID: document.objectID)) {
                DocumentReturnTakenDebtListRowView(date: document.date, contact: document.cdContact?.name, debt: document.cdDebt?.name, value: document.value?.decimalValue ?? 0, comment: document.comment)
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
                NavigationLink(value: Coordinator.DocumentReturnTakenDebtListView.new) {
                    Text("Добавить")
                }
            }
        }
        .navigationTitle(objectType.listTitle)
        .navigationDestination(for: Coordinator.DocumentReturnTakenDebtListView.self, destination: { route in

            switch route {
            case .new:
                let viewModel = DocumentReturnTakenDebtEditViewModel()
                DocumentReturnTakenDebtEditView(viewModel: viewModel, objectType: objectType)
            case let .edit(objectID):
                let viewModel = DocumentReturnTakenDebtEditViewModel(id: objectID)
                DocumentReturnTakenDebtEditView(viewModel: viewModel, objectType: objectType)
            }
            
        })
        
    }
    
}

#Preview {
    DocumentReturnGiveoutDebtListView(objectType: .documentReturnGiveoutDebt, viewModel: DocumentReturnGiveoutDebtListViewModel())
}
