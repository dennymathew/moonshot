//
//  Mission.swift
//  Moonshot
//
//  Created by Denny Mathew on 02/12/20.
//

import Foundation
struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    var formattedLaunchDate: String {
        guard let date = launchDate else {
            return "N/A"
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}
