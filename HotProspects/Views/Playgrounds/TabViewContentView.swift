//
//  TabViewContentView.swift
//  HotProspects
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 10/08/24.
//

import SwiftUI

struct TabViewContentView: View {
    
    @State private var selectedTab = "One"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                Button("Show tab 2") {
                    selectedTab = "Two"
                }
                .navigationTitle("One")
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("One")
            
            NavigationStack {
                Button("Show tab 1") {
                    selectedTab = "One"
                }
                .navigationTitle("Two")
            }
            .tabItem {
                Label("Two", systemImage: "circle")
            }
            .tag("Two")
        }
    }
}

#Preview {
    TabViewContentView()
}
