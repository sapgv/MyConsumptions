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
                    
                    TextField(text: $viewModel.cdCatalogStateIncome.name.defaultValue("")) {
                        Text("Наименование")
                    }
                    
                    Text("Наименование")
                    
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
        .onReceive(viewModel.saveCompletion) {
            self.coordinator.path.removeLast()
        }
        
        
        
    }
}

//#Preview {
//    CatalogStateIncomeEditView()
//}
