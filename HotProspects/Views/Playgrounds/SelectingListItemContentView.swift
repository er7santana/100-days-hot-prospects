//
//  SelectingListItemContentView.swift
//  HotProspects
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 10/08/24.
//

import SwiftUI

struct SelectingListItemContentView: View {
    
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    
    // Option 1 - simple selection
    //    @State private var selection: String?
    
    //option 2 - multiple selection
    @State private var selection = Set<String>()
    
    var body: some View {
        NavigationStack {
            VStack {
                List(users, id: \.self, selection: $selection) { user in
                    Text(user)
                }
                
                Spacer()
                
                // Option 1
                //                if let selection {
                //                    Text("You seleced \(selection)")
                //                }
                // Option 2
                if selection.isEmpty == false {
                    Text("You selected \(selection.formatted())")
                }
            }
            .navigationTitle("Members")
            // Option 2
            .toolbar {
                EditButton()
            }
        }
    }
}

#Preview {
    SelectingListItemContentView()
}
