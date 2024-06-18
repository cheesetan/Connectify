//
//  LivePostManager.swift
//  Connectify
//
//  Created by Tristan Chay on 18/6/24.
//

import SwiftUI

class LivePostManager: ObservableObject {
    static let shared: LivePostManager = .init()
    
    @Published var livePosts: [Post] = [] {
        didSet {
            save()
        }
    }
        
    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "livePosts.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedHomeworks = try? propertyListEncoder.encode(livePosts)
        try? encodedHomeworks?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
                
        if let retrievedHomeworkData = try? Data(contentsOf: archiveURL),
            let homeworksDecoded = try? propertyListDecoder.decode([Post].self, from: retrievedHomeworkData) {
            livePosts = homeworksDecoded
        }
    }
}
