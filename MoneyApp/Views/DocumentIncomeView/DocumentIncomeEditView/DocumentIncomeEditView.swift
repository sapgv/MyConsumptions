//
//  DocumentIncomeEditView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 28.07.2024.
//

import SwiftUI

struct DocumentIncomeEditView: View {
    
    var viewModel: DocumentIncomeEditViewModel
    
    var objectType: ObjectType
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    let viewModel = DocumentIncomeEditViewModel()
    return DocumentIncomeEditView(viewModel: viewModel, objectType: .documentIncome)
}
