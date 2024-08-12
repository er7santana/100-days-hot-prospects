//
//  ContextMenuContainerView.swift
//  HotProspects
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 11/08/24.
//

import SwiftUI

struct ContextMenuContainerView: View {
    
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("HELLO, WORLD!")
                .font(.headline)
                .padding()
                .background(backgroundColor)
                .clipShape(.rect(cornerRadius: 8))
            
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
                        backgroundColor = .red
                    }
                    
                    Button("Green", systemImage: "plus") {
                        backgroundColor = .green
                    }
                    
                    Button("Blue", systemImage: "star") {
                        backgroundColor = .blue
                    }
                }
        }
    }
}

#Preview {
    ContextMenuContainerView()
}
