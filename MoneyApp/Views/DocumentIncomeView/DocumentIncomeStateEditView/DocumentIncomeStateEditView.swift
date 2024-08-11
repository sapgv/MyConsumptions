//
//  DocumentIncomeStateEditView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import SwiftUI

struct DocumentIncomeStateEditView: View {
    
    @StateObject var viewModel: DocumentIncomeStateEditViewModel
    
    var completion: ((CDDocumentIncomeState) -> Void)?
    
    var body: some View {
        
        NavigationStack {
            
            List {
                
                Section {
                    
                    NavigationLink(value: Coordinator.DocumentIncomeStateEditView.selectStateIncome) {
                        Text(viewModel.cdDocumentIncomeState.cdIncomeState?.name ?? "")
                    }
                    
                }
                
                Section {
                    
                    DecimalValueRow(value: $viewModel.cdDocumentIncomeState.value)
                    
                }
                
                Section {
                    
                    CommentView(text: $viewModel.cdDocumentIncomeState.comment)
                        .frame(minHeight: 100)
                    
                }
                header: {
                    Text("Комментарий")
                }
                
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        self.viewModel.save()
                    }, label: {
                        Text("Сохранить")
                    })
                }
            }
            .onReceive(self.viewModel.saveCompletion, perform: { cdDocumentIncomeState in
                self.completion?(cdDocumentIncomeState)
            })
            .navigationTitle(ObjectType.catalogStateIncome.editTitle)
            .navigationDestination(for: Coordinator.DocumentIncomeStateEditView.self) { route in
                switch route {
                case .selectStateIncome:
                    CatalogCommonSelectListView<CDCatalogStateIncome>(objectType: .catalogStateIncome) { cdStateIncome in
                        self.viewModel.updateState(cdStateIncome: cdStateIncome)
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    DocumentIncomeStateEditView(viewModel: DocumentIncomeStateEditViewModel(viewContext: CoreDataStack.previewStack.viewContext))
}
