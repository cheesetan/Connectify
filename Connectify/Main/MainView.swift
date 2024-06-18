//
//  MainView.swift
//  Connectify
//
//  Created by Tristan Chay on 18/6/24.
//

import SwiftUI

struct MainView: View {
    
    @AppStorage("isStudentAccount", store: .standard) private var isStudentAccount = false
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }
            if isStudentAccount {
                CreatePostView()
                    .tabItem { Label("Create", systemImage: "plus.square.dashed") }
            } else {
                PostsReviewView()
                    .tabItem { Label("Review", systemImage: "checkmark.seal.fill") }
            }
            AccountView()
                .tabItem { Label("Account", systemImage: "person.fill") }
        }
    }
}

#Preview {
    MainView()
}
