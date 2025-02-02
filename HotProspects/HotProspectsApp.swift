//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 10/08/24.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
