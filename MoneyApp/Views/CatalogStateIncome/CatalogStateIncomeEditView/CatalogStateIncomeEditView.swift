//
//  CatalogStateIncomeEditView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 02.04.2024.
//

import SwiftUI

struct CatalogStateIncomeEditView: View {
    
    @StateObject var viewModel: CatalogStateIncomeEditViewModel
    
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        
        List {
            
            Section {
                
                VStack(alignment: .leading)  {
                    
                    CatalogStateIncomeEditNameView(name: $viewModel.cdCatalogStateIncome.name.defaultValue(""))
                    
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
        
        
        
    }
}

#Preview {
    let viewModel = CatalogStateIncomeEditViewModel(id: CoreDataStack.cdCatalogStateIncomePreview!.objectID, coreData: CoreDataStack.previewStack)
    return NavigationStack {
        CatalogStateIncomeEditView(viewModel: viewModel)
    }
}
