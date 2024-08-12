//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 11/08/24.
//

import SwiftData
import SwiftUI

struct EditProspectView: View {
    
    let prospect: Prospect
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var emailAddress = ""
    
    var isSaveButtonDisabled: Bool {
        return name.isEmpty || emailAddress.isEmpty
    }
    
    init(prospect: Prospect) {
        self.prospect = prospect
        _name = State(initialValue: prospect.name)
        _emailAddress = State(initialValue: prospect.emailAddress)
    }
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $name)
                    .textContentType(.name)
            }
            Section("Email") {
                TextField("Email", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
        }
        .navigationTitle("Edit item")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    save()
                }
                .disabled(isSaveButtonDisabled)
            }
        }
    }
    
    func save() {
        let newProspect = Prospect(name: name, emailAddress: emailAddress, isContacted: prospect.isContacted)
        modelContext.delete(prospect)
        modelContext.insert(newProspect)
        dismiss()
    }
}

#Preview {
    
    do {
        let config = try ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: Prospect.self, configurations: config)
        return NavigationStack {
            EditProspectView(prospect: Prospect(name: "Taylor Swift", emailAddress: "taylor@swift.com", isContacted: true))
                .modelContainer(modelContainer)
        }
    } catch {
        return Text("Failed to render")
    }
}
