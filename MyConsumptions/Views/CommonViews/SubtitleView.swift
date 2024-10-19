//
//  SubtitleView.swift
//  MoneyApp
//
//  Created by Grigory Sapogov on 19.07.2024.
//

import SwiftUI

struct SubtitleView: View {
    
    var name: String?
    
    var subtitle: String?
    
    init(name: String?, subtitle: String?) {
        self.name = name
        self.subtitle = subtitle
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(name ?? "")
            if let subtitle = subtitle {
                Text(subtitle)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            SubtitleView(name: "Name", subtitle: "Subtitle")
        }
    }
}
