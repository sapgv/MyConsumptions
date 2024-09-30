//
//  DocumentIncomeEditView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import SwiftUI

struct DocumentIncomeEditView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    @StateObject var viewModel: DocumentIncomeEditViewModel
    
    var objectType: ObjectType
    
    @State private var addNewState: Bool = false
    
    @State private var editState: CDDocumentIncomeState?
    
    var body: some View {
        
        List {
            
            Section {
            
                DocumentDatePicker(date: $viewModel.cdDocumentIncome.date)
                
                NavigationLink(value: Coordinator.DocumentIncomeEditView.selectWallet) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.cdDocumentIncome.cdCatalogWallet?.name ?? "")
                        Text("Кошелек")
                            .foregroundStyle(.secondary)
                    }
                   
                }
                .listRowBackground(Color(UIColor.systemBackground))
                
            }
            
            Section {
                
                ForEach(viewModel.cdDocumentIncome.cdDocumentIncomeStates) { state in
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8, content: {
                            Text(state.cdIncomeState?.name ?? "")
                                .contentShape(Rectangle())
                            if let comment = state.comment {
                                Text(comment)
                                    .foregroundStyle(.secondary)
                            }
                            
                        })
                        Spacer()
                        ValueView(value: state.value?.decimalValue)
                            .font(.title)
                            .foregroundStyle(.income)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.editState = state
                    }
                    
                }
                
                
            }
            header:  {
                
                HStack(alignment: .center, spacing: 8) {
                    Text("Доходы")
                    Spacer()
                    Button("Добавить") {
                        self.addNewState = true
                    }
                }
                
            }
            
            Section {
                
                CommentTextView(text: $viewModel.cdDocumentIncome.comment.defaultValue(""))
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
        .sheet(isPresented: $addNewState, content: {
            let viewModel = DocumentIncomeStateEditViewModel(viewContext: self.viewModel.createChildContext())
            DocumentIncomeStateEditView(viewModel: viewModel) { cdDocumentIncomeState in
                self.viewModel.addState(cdDocumentIncomeState: cdDocumentIncomeState)
                self.addNewState = false
            }
        })
        .sheet(item: $editState, content: { state in
            let viewModel = DocumentIncomeStateEditViewModel(id: state.objectID, viewContext: self.viewModel.createChildContext())
            DocumentIncomeStateEditView(viewModel: viewModel) { _ in
                self.editState = nil
                self.viewModel.refresh()
            }
        })
        .navigationTitle(objectType.editTitle)
        .navigationDestination(for: Coordinator.DocumentIncomeEditView.self) { route in
            switch route {
            case .selectWallet:
                CatalogCommonSelectListView<CDCatalogWallet>(objectType: .catalogWallet, selected: self.viewModel.cdDocumentIncome.cdCatalogWallet) { cdWallet in
                    self.viewModel.updateWallet(cdWallet: cdWallet)
                }
            default:
                EmptyView()
            }
        }
        
    }
}

#Preview {
    let viewModel = DocumentIncomeEditViewModel()
    return DocumentIncomeEditView(viewModel: viewModel, objectType: .documentIncome)
}
