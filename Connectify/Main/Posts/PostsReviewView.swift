//
//  PostsReviewView.swift
//  Connectify
//
//  Created by Tristan Chay on 18/6/24.
//

import SwiftUI

struct PostsReviewView: View {
    
    @State var feedbackField = ""
    @State var isActive = false
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var lpManager: LivePostManager = .shared
    @ObservedObject var ppManager: PendingPostManager = .shared
    
    var body: some View {
        NavigationStack {
            if ppManager.pendingPosts.isEmpty {
                Text("There are no posts awaiting Review.")
                    .padding(.horizontal)
            } else {
                List {
                    ForEach(ppManager.pendingPosts, id: \.id) { pendingPost in
                        NavigationLink(isActive: $isActive) {
                            Form {
                                Section("Information") {
                                    Text(pendingPost.productName)
                                    Text(pendingPost.price)
                                }
                                
                                Section("Value Proposition") {
                                    Text(pendingPost.valueProp)
                                }
                                
                                Section("Business and Marketing Plan") {
                                    Text(pendingPost.businessAndMarketingPlan)
                                }
                                
                                Section {
                                    Button("Approve") {
                                        lpManager.livePosts.insert(pendingPost, at: 0)
                                        ppManager.pendingPosts.removeAll(where: { $0 == pendingPost})
                                        feedbackField = ""
                                        isActive = false
                                        dismiss.callAsFunction()
                                    }
                                    .foregroundStyle(.green)
                                }
                                
                                Section {
                                    TextField("Type your Feedback here...", text: $feedbackField)
                                    Button("Reject", role: .destructive) {
                                        ppManager.pendingPosts.removeAll(where: { $0 == pendingPost})
                                        feedbackField = ""
                                        isActive = false
                                        dismiss.callAsFunction()
                                    }
                                    .disabled(feedbackField.isEmpty)
                                }
                            }
                        } label: {
                            VStack(alignment: .leading) {
                                Text(pendingPost.productName)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text(pendingPost.valueProp)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        ppManager.pendingPosts.remove(atOffsets: indexSet)
                    }
                }
            }
        }
    }
}

#Preview {
    PostsReviewView()
}
