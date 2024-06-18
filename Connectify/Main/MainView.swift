//
//  MainView.swift
//  Connectify
//
//  Created by Tristan Chay on 18/6/24.
//

import SwiftUI

struct MainView: View {
    
    @AppStorage("isStudentAccount", store: .standard) private var isStudentAccount = false
    
    @AppStorage("accounttype", store: .standard) private var accounttype = "Investor"
    
    var body: some View {
        TabView {
            if isStudentAccount {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                CreatePostView()
                    .tabItem {
                        Label("Create", systemImage: "plus.square.dashed")
                    }
            } else {
                if accounttype == "Investor" {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                } else {
                    PostsReviewView()
                        .tabItem {
                            Label("Review", systemImage: "checkmark.seal.fill")
                        }
                }
            }
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
            
        }
    }
}

#Preview {
    MainView()
}
