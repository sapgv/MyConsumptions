//
//  CatalogStateIncomeEditView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 02.04.2024.
//

import SwiftUI

struct CatalogStateIncomeEditView: View {

    @EnvironmentObject var coordinator: Coordinator
    
    @StateObject var viewModel: CatalogStateIncomeEditViewModel
    
    @FocusState private var focusedField: CatalogStateIncomeEditView.FocusField?
    
    var body: some View {
        
        List {
            
            Section {
                
                VStack(alignment: .leading)  {
                    
                    EditNameView(name: $viewModel.cdCatalogStateIncome.name.defaultValue(""))
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

extension CatalogStateIncomeEditView {
    
    enum FocusField {
        case name
    }
    
}

#Preview {
    let viewModel = CatalogStateIncomeEditViewModel(id: CoreDataStack.cdCatalogStateIncomePreview!.objectID, coreData: CoreDataStack.previewStack)
    return NavigationStack {
        CatalogStateIncomeEditView(viewModel: viewModel)
    }
}
