//
//  HomeView.swift
//  Connectify
//
//  Created by Tristan Chay on 18/6/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var searchText = ""
    
    @ObservedObject var lpManager: LivePostManager = .shared
    
    @AppStorage("isStudentAccount", store: .standard) private var isStudentAccount = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredPosts(), id: \.id) { post in
                    NavigationLink {
                        Form {
                            Section("Information") {
                                Text(post.productName)
                                Text(post.price)
                            }
                            
                            Section("Value Proposition") {
                                Text(post.valueProp)
                            }
                            
                            Section("Business and Marketing Plan") {
                                Text(post.businessAndMarketingPlan)
                            }
                            
                            Section("Contact") {
                                Link(destination: URL(string: "mailto:\(post.email)")!) {
                                    LabeledContent("Email:", value: post.email)
                                }
                                .multilineTextAlignment(.trailing)
                            }
                        }
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(post.productName)
                                .font(.headline)
                                .fontWeight(.bold)
                            Text(post.valueProp)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(2)
                        }
                    }
                }
                .onDelete { indexSet in
                    lpManager.livePosts.remove(atOffsets: indexSet)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Your Feed")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    if isStudentAccount {
                        Text("Student Account")
                            .fontWeight(.bold)
                            .foregroundStyle(.blue)
                    } else {
                        Text("Investor Account")
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                    }
                }
            }
        }
    }
    
    func filteredPosts() -> [Post] {
        if searchText.isEmpty {
            return lpManager.livePosts
        } else {
            return lpManager.livePosts.filter({ $0.productName.uppercased().contains(searchText.uppercased()) })
        }
    }
}

#Preview {
    HomeView()
}
