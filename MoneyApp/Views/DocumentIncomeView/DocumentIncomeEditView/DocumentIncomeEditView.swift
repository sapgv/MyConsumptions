//
//  DocumentIncomeEditView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import SwiftUI

struct DocumentIncomeEditView: View {
    
    @StateObject var viewModel: DocumentIncomeEditViewModel
    
    var objectType: ObjectType
    
    @State private var addNewState: Bool = false
    
    @State private var editState: CDDocumentIncomeState?
    
    var body: some View {
        
        List {
            
            Section {
            
                DatePicker(
                    "Дата",
                    selection: $viewModel.cdDocumentIncome.date.defaultValue(.now),
                    displayedComponents: [.hourAndMinute, .date]
                )
                
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
                        Text(state.cdIncomeState?.name ?? "")
                            .contentShape(Rectangle())
                        Spacer()
                        Text("\(state.value ?? 0)")
                            .font(.title)
                            .foregroundStyle(.green)
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
                
                CommentView(text: $viewModel.cdDocumentIncome.comment)
                    .frame(minHeight: 100)
                
                
            }
            header:  {
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
//        .navigationDestination(isPresented: $addNewState, destination: {
//            let viewModel = DocumentIncomeStateEditViewModel(viewContext: self.viewModel.createChildContext())
//            DocumentIncomeStateEditView(viewModel: viewModel)
//        })
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
        .navigationDestination(for: Coordinator.DocumentIncomeEditView.self) { route in
            switch route {
            case .selectWallet:
                CatalogCommonSelectListView<CDCatalogWallet>(objectType: .catalogContact, selected: self.viewModel.cdDocumentIncome.cdCatalogWallet) { cdWallet in
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
