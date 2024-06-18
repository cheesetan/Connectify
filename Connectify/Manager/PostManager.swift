//
//  PostManager.swift
//  Connectify
//
//  Created by Tristan Chay on 18/6/24.
//

import Foundation

struct Post: Identifiable, Codable {
    var id = UUID()
    var productName: String
    var price: String
    var valueProp: String
    var businessAndMarketingPlan: String
}

class PendingPostManager: ObservableObject {
    static let shared: PendingPostManager = .init()
    
    @Published var pendingPosts: [Post] = [] {
        didSet {
            save()
        }
    }
        
    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "pendingPosts.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedHomeworks = try? propertyListEncoder.encode(pendingPosts)
        try? encodedHomeworks?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
                
        if let retrievedHomeworkData = try? Data(contentsOf: archiveURL),
            let homeworksDecoded = try? propertyListDecoder.decode([Post].self, from: retrievedHomeworkData) {
            pendingPosts = homeworksDecoded
        }
    }
}
