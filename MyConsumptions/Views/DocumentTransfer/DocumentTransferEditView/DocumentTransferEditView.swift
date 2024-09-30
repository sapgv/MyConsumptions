//
//  DocumentTransferEditView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 30.09.2024.
//

import SwiftUI

struct DocumentTransferEditView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    @StateObject var viewModel: DocumentTransferEditViewModel
    
    var objectType: ObjectType
    
    var body: some View {
        
        List {
            
            Section {
            
                DocumentDatePicker(date: $viewModel.cdDocumentTransfer.date)
                
                NavigationLink(value: Coordinator.DocumentTransferEditView.selectWalletFrom) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.cdDocumentTransfer.cdCatalogWalletFrom?.name ?? "")
                        Text("Кошелек откуда")
                            .foregroundStyle(.secondary)
                    }
                   
                }
                .listRowBackground(Color(UIColor.systemBackground))
                
                NavigationLink(value: Coordinator.DocumentTransferEditView.selectWalletTo) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.cdDocumentTransfer.cdCatalogWalletTo?.name ?? "")
                        Text("Кошелек куда")
                            .foregroundStyle(.secondary)
                    }
                   
                }
                .listRowBackground(Color(UIColor.systemBackground))
                
            }
            
            Section {
                
                DecimalValueRow(value: $viewModel.cdDocumentTransfer.value, valueForegroundStyle: .transfer)
                
            }
            
            Section {
                
                CommentTextView(text: $viewModel.cdDocumentTransfer.comment.defaultValue(""))
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
        .navigationDestination(for: Coordinator.DocumentTransferEditView.self) { route in
            switch route {
            case .selectWalletFrom:
                CatalogCommonSelectListView<CDCatalogWallet>(objectType: .catalogWallet, selected: self.viewModel.cdDocumentTransfer.cdCatalogWalletFrom) { cdWallet in
                    self.viewModel.updateWalletFrom(cdWallet: cdWallet)
                }
            case .selectWalletTo:
                CatalogCommonSelectListView<CDCatalogWallet>(objectType: .catalogWallet, selected: self.viewModel.cdDocumentTransfer.cdCatalogWalletTo) { cdWallet in
                    self.viewModel.updateWalletTo(cdWallet: cdWallet)
                }
            }
        }
        
    }
}

#Preview {
    let viewModel = DocumentTransferEditViewModel()
    return DocumentTransferEditView(viewModel: viewModel, objectType: .documentTransfer)
}
