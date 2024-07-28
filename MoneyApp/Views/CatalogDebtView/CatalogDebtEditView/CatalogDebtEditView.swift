//
//  CatalogDebtEditView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 19.07.2024.
//

import SwiftUI

struct CatalogDebtEditView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    @StateObject var viewModel: CatalogDebtEditViewModel
    
    @FocusState private var focusedField: CatalogStateIncomeEditView.FocusField?
    
    var objectType: ObjectType
    
    var body: some View {
        
        List {
            
            Section {
                
//                NavigationLink {
//                    CatalogCommonSelectListView<CDCatalogContact>(objectType: .catalogContact, selected: self.viewModel.cdCatalogDebt.cdContact) { cdContact in
//                        self.viewModel.updateContact(cdContact: cdContact)
//                    }
//                } label: {
//                    CatalogDebtContactView(name: viewModel.cdCatalogDebt.cdContact?.name)
//                }

                NavigationLink(value: Coordinator.CatalogDebtEditView.selectContact) {
                    CatalogDebtContactView(name: viewModel.cdCatalogDebt.cdContact?.name)
                }
                
                HStack(spacing: 8, content: {
                    
                    Text("Тип долга")
                        .foregroundStyle(.secondary)
                    
                    Picker("", selection: $viewModel.cdCatalogDebt.debtType_) {
                        ForEach(DebtType.allCases.map { $0.title }, id: \.self) { debtType in
                            Text(debtType)
                                .foregroundStyle(Color.red)
                                .tag(Optional(debtType))
                            
                        }
                    }
                    .tint(.primary)
                    
                })
                
            }
            
            Section {
                
                EditNameView(name: $viewModel.cdCatalogDebt.name.defaultValue(""))
                    .focused($focusedField, equals: .name)
                
            }
            
        }
        .navigationTitle(objectType.editTitle)
        .toolbar {
            ToolbarItem {
                Button(action: {
                    self.viewModel.save()
                }, label: {
                    Text("Сохранить")
                })
            }
        }
        .onReceive(viewModel.saveCompletion) {
            self.coordinator.path.removeLast()
        }
        .onAppear(perform: {
            self.focusedField = .name
        })
        .navigationDestination(for: Coordinator.CatalogDebtEditView.self) { route in
            switch route {
            case .selectContact:
                CatalogCommonSelectListView<CDCatalogContact>(objectType: .catalogContact, selected: self.viewModel.cdCatalogDebt.cdContact) { cdContact in
                    self.viewModel.updateContact(cdContact: cdContact)
                }
            }
        }
        
    }
    
}

extension CatalogDebtEditView {
    
    enum FocusField {
        case name
    }
    
}

#Preview {
    let viewModel = CatalogDebtEditViewModel(id: CoreDataStack.cdCatalogDebtPreview!.objectID, coreData: CoreDataStack.previewStack)
    return NavigationStack {
        CatalogDebtEditView(viewModel: viewModel, objectType: .catalogDebt)
    }
}
