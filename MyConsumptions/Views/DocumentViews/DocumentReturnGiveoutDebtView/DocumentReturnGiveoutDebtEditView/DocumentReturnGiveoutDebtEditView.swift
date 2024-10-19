//
//  DocumentReturnGiveoutDebtEditView.swift
//  MyConsumptions
//
//  Created by Grigory Sapogov on 19.10.2024.
//

import SwiftUI

struct DocumentReturnGiveoutDebtEditView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    @StateObject var viewModel: DocumentReturnGiveoutDebtEditViewModel
    
    var objectType: ObjectType
    
    var body: some View {
        
        List {
            
            Section {
            
                DocumentDatePicker(date: $viewModel.cdDocument.date)
                
                NavigationLink(value: Coordinator.DocumentReturnGiveoutDebtEditView.selectContact) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.cdDocument.cdContact?.name ?? "")
                        Text("Контакт")
                            .foregroundStyle(.secondary)
                    }
                   
                }
                .listRowBackground(Color(UIColor.systemBackground))
                
                NavigationLink(value: Coordinator.DocumentReturnGiveoutDebtEditView.selectDebt) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.cdDocument.cdDebt?.name ?? "")
                        Text("Кошелек куда")
                            .foregroundStyle(.secondary)
                    }
                   
                }
                .listRowBackground(Color(UIColor.systemBackground))
                
            }
            
            Section {
                
                DecimalValueRow(value: $viewModel.cdDocument.value, valueForegroundStyle: .income)
                
            }
            
            Section {
                
                CommentTextView(text: $viewModel.cdDocument.comment.defaultValue(""))
                    .frame(minHeight: 100)

            }
            header:  {
                Text("Комментарий")
            }
            
            
        }
        .onReceive(self.viewModel.saveCompletion, perform: { cdDocumentIncomeState in
            self.coordinator.path.removeLast()
        })
        .toolbar {
            ToolbarItem {
                Button(action: {
                    self.viewModel.save()
                }, label: {
                    Text("Сохранить")
                })
            }
        }
        .navigationTitle(objectType.editTitle)
        .navigationDestination(for: Coordinator.DocumentReturnGiveoutDebtEditView.self) { route in
            switch route {
            case .selectContact:
                CatalogCommonSelectListView<CDCatalogContact>(objectType: .catalogContact, selected: self.viewModel.cdDocument.cdContact) { cdContact in
                    self.viewModel.updateContact(cdContact: cdContact)
                }
            case .selectDebt:
                CatalogCommonSelectListView<CDCatalogDebt>(objectType: .catalogDebt, selected: self.viewModel.cdDocument.cdDebt) { cdDebt in
                    self.viewModel.updateDebt(cdDebt: cdDebt)
                }
            }
        }
        
    }
}

#Preview {
    let viewModel = DocumentTransferEditViewModel()
    return DocumentTransferEditView(viewModel: viewModel, objectType: .documentTransfer)
}

