//
//  DocumentConsumptionEditView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 30.09.2024.
//

import SwiftUI

struct DocumentConsumptionEditView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    @StateObject var viewModel: DocumentConsumptionEditViewModel
    
    var objectType: ObjectType
    
    @State private var addNewState: Bool = false
    
    @State private var editState: CDDocumentConsumptionState?
    
    var body: some View {
        
        List {
            
            Section {
            
                DocumentDatePicker(date: $viewModel.cdDocumentConsumption.date)
                
                NavigationLink(value: Coordinator.DocumentConsumptionEditView.selectWallet) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.cdDocumentConsumption.cdCatalogWallet?.name ?? "")
                        Text("Кошелек")
                            .foregroundStyle(.secondary)
                    }
                   
                }
                .listRowBackground(Color(UIColor.systemBackground))
                
            }
            
            Section {
                
                ForEach(viewModel.cdDocumentConsumption.cdDocumentConsumptionStates) { state in
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8, content: {
                            Text(state.cdConsumptionState?.name ?? "")
                                .contentShape(Rectangle())
                            if let comment = state.comment {
                                Text(comment)
                                    .foregroundStyle(.secondary)
                            }
                            
                        })
                        Spacer()
                        ValueView(value: state.value?.decimalValue)
                            .font(.title)
                            .foregroundStyle(.consumption)
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
                
                CommentTextView(text: $viewModel.cdDocumentConsumption.comment.defaultValue(""))
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
            let viewModel = DocumentConsumptionStateEditViewModel(viewContext: self.viewModel.createChildContext())
            DocumentConsumptionStateEditView(viewModel: viewModel) { cdDocumentConsumptionState in
                self.viewModel.addState(cdDocumentConsumptionState: cdDocumentConsumptionState)
                self.addNewState = false
            }
        })
        .sheet(item: $editState, content: { state in
            let viewModel = DocumentConsumptionStateEditViewModel(id: state.objectID, viewContext: self.viewModel.createChildContext())
            DocumentConsumptionStateEditView(viewModel: viewModel) { _ in
                self.editState = nil
                self.viewModel.refresh()
            }
        })
        .navigationTitle(objectType.editTitle)
        .navigationDestination(for: Coordinator.DocumentConsumptionEditView.self) { route in
            switch route {
            case .selectWallet:
                CatalogCommonSelectListView<CDCatalogWallet>(objectType: .catalogWallet, selected: self.viewModel.cdDocumentConsumption.cdCatalogWallet) { cdWallet in
                    self.viewModel.updateWallet(cdWallet: cdWallet)
                }
            default:
                EmptyView()
            }
        }
        
    }
}

#Preview {
    let viewModel = DocumentConsumptionEditViewModel()
    return DocumentConsumptionEditView(viewModel: viewModel, objectType: .documentConsumption)
}
