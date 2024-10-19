//
//  DocumentConsumptionStateEditView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 30.09.2024.
//

import SwiftUI

struct DocumentConsumptionStateEditView: View {
    
    @StateObject var viewModel: DocumentConsumptionStateEditViewModel
    
    @StateObject var coordinator: Coordinator = Coordinator()
    
    @State private var firstAppear = true
    
    var completion: ((CDDocumentConsumptionState) -> Void)?
    
    var body: some View {
        
        NavigationStack(path: $coordinator.path) {
            
            List {
                
                Section {
                    
                    NavigationLink(value: Coordinator.DocumentConsumptionStateEditView.selectStateConsumption) {
                        SubtitleView(name: viewModel.cdDocumentConsumptionState.cdConsumptionState?.name, subtitle: "Статья расхода")
                    }
                    
                }
                
                Section {
                    
                    DecimalValueRow(value: $viewModel.cdDocumentConsumptionState.value, valueForegroundStyle: .consumption)
                    
                }
                
                Section {
                    
                    CommentTextView(text: $viewModel.cdDocumentConsumptionState.comment.defaultValue(""))
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
                        self.coordinator.path.append(Coordinator.DocumentConsumptionStateEditView.selectStateConsumption)
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
            .onReceive(self.viewModel.saveCompletion, perform: { cdDocumentConsumptionState in
                self.completion?(cdDocumentConsumptionState)
            })
            .navigationTitle(ObjectType.catalogStateConsumption.editTitle)
            .navigationDestination(for: Coordinator.DocumentConsumptionStateEditView.self) { route in
                switch route {
                case .selectStateConsumption:
                    CatalogCommonSelectListView<CDCatalogStateConsumption>(objectType: .catalogStateConsumption) { cdStateConsumption in
                        self.viewModel.updateState(cdStateConsumption: cdStateConsumption)
                    }
                    .environmentObject(coordinator)
                }
            }
            
        }
        
    }
    
}

#Preview {
    DocumentConsumptionStateEditView(viewModel: DocumentConsumptionStateEditViewModel(viewContext: CoreDataStack.previewStack.viewContext))
}
