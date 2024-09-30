//
//  DocumentIncomeStateEditView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import SwiftUI

struct DocumentIncomeStateEditView: View {
    
    @StateObject var viewModel: DocumentIncomeStateEditViewModel
    
    @StateObject var coordinator: Coordinator = Coordinator()
    
    @State private var firstAppear = true
    
    var completion: ((CDDocumentIncomeState) -> Void)?
    
    var body: some View {
        
        NavigationStack(path: $coordinator.path) {
            
            List {
                
                Section {
                    
                    NavigationLink(value: Coordinator.DocumentIncomeStateEditView.selectStateIncome) {
                        SubtitleView(name: viewModel.cdDocumentIncomeState.cdIncomeState?.name, subtitle: "Статья дохода")
                    }
                    
                }
                
                Section {
                    
                    DecimalValueRow(value: $viewModel.cdDocumentIncomeState.value, valueForegroundStyle: .income)
                    
                }
                
                Section {
                    
                    CommentTextView(text: $viewModel.cdDocumentIncomeState.comment.defaultValue(""))
                        .frame(minHeight: 100)
                    
                }
            header: {
                Text("Комментарий")
            }
                
            }
            .onAppear {
                
                defer {
                    self.firstAppear = false
                }
                
                if self.firstAppear, self.viewModel.selectStateOnApper {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.coordinator.path.append(Coordinator.DocumentIncomeStateEditView.selectStateIncome)
                    }
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
                    .environmentObject(coordinator)
                }
            }
            
        }
        
    }
    
}

#Preview {
    DocumentIncomeStateEditView(viewModel: DocumentIncomeStateEditViewModel(viewContext: CoreDataStack.previewStack.viewContext))
}
