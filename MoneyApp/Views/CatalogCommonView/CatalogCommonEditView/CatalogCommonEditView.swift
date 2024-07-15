//
//  CatalogCommonEditView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 15.07.2024.
//

import SwiftUI
import CoreData

struct CatalogCommonEditView<T: CDCatalogName>: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    @StateObject var viewModel: CatalogCommonEditViewModel<T>
    
    @FocusState private var focusedField: CatalogCommonEditView.FocusField?
    
    var body: some View {
        
        List {
            
            Section {
                
                VStack(alignment: .leading)  {
                    
                    EditNameView(name: $viewModel.cdCatalog.name.defaultValue(""))
                        .focused($focusedField, equals: .name)
                    
                }
                
            }
            
        }
        .navigationTitle("Доход")
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
        
        
    }
    
}

extension CatalogCommonEditView {
    
    enum FocusField {
        case name
    }
    
}

#Preview {
    let viewModel = CatalogCommonEditViewModel<CDCatalogStateIncome>(id: CoreDataStack.cdCatalogStateIncomePreview!.objectID, coreData: CoreDataStack.previewStack)
    return NavigationStack {
        CatalogCommonEditView(viewModel: viewModel)
    }
}
