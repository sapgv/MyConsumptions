//
//  DocumentIncomeStateEditView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import SwiftUI

struct DocumentIncomeStateEditView: View {
    
    @StateObject var viewModel: DocumentIncomeStateEditViewModel
    
    @State private var selectState: Bool = false
    
    @State private var firstAppear = true
    
    var completion: ((CDDocumentIncomeState) -> Void)?
    
    var body: some View {
        
        NavigationStack {
            
            List {
                
                Section {
                    
                    NavigationLink(value: Coordinator.DocumentIncomeStateEditView.selectStateIncome) {
                        SubtitleView(name: viewModel.cdDocumentIncomeState.cdIncomeState?.name, subtitle: "Статья дохода")
                    }
                    
                }
                
                Section {
                    
                    DecimalValueRow(value: $viewModel.cdDocumentIncomeState.value)
                    
                }
                
                Section {
                    
                    CommentView(text: $viewModel.cdDocumentIncomeState.comment.defaultValue(""))
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
                        self.selectState = true
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
            .navigationDestination(isPresented: self.$selectState, destination: {
                CatalogCommonSelectListView<CDCatalogStateIncome>(objectType: .catalogStateIncome) { cdStateIncome in
                    self.viewModel.updateState(cdStateIncome: cdStateIncome)
                }
            })
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
