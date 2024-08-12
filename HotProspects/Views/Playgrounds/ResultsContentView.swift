//
//  ResultsContentView.swift
//  HotProspects
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 11/08/24.
//

import SwiftUI

struct ResultsContentView: View {
    
    @State private var output = ""
    let shaftConnector = ShaftConnector()
    
    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
    }
    
    func fetchReadings() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result
        
        switch result {
        case .success(let str):
            output = str
        case .failure(let error):
            output = "Error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ResultsContentView()
}
