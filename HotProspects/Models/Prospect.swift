//
//  Prospect.swift
//  HotProspects
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 11/08/24.
//

import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}
