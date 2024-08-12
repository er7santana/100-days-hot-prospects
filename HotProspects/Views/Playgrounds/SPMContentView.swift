//
//  SPMContentView.swift
//  HotProspects
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 11/08/24.
//

import SamplePackage
import SwiftUI

struct SPMContentView: View {
    
    let possibleNumbers = 1...60
    
    @State private var results = ""
    
    var body: some View {
        VStack {
            Text("Megasena")
                .font(.largeTitle)
                .padding(.top, 30)
            
            Spacer()
            
            Text(results)
                .font(.title)
                .onAppear {
                    results = getNumbers()
                }
            
            Spacer()
            
            Button("Get numbers") {
                withAnimation {
                    results = getNumbers()
                }
            }
        }
    }
    
    func getNumbers() -> String {
        let selected = possibleNumbers.random(6).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
}

#Preview {
    SPMContentView()
}
