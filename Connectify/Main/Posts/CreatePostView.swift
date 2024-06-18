//
//  CreatePostView.swift
//  Connectify
//
//  Created by Tristan Chay on 18/6/24.
//

import SwiftUI

struct CreatePostView: View {
    
    @State var productName = ""
    @State var price = ""
    
    @State var valueProp = ""
    @State var businessAndMarketingPlan = ""
    
    @State var pendingReviewPosts = false
    
    @ObservedObject var ppManager: PendingPostManager = .shared
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section("Information") {
                    TextField("Name", text: $productName)
                    TextField("Asking Price", text: $price)
                }
                
                Section("Description") {
                    TextField("Unique Value Proposition", text: $valueProp, axis: .vertical)
                    TextField("Business And Marketing Plan", text: $businessAndMarketingPlan, axis: .vertical)
                }
                
                Section {
                    Button("Post for Review") {
                        withAnimation {
                            ppManager.pendingPosts.append(
                                Post(productName: productName,
                                     price: price,
                                     valueProp: valueProp,
                                     businessAndMarketingPlan: businessAndMarketingPlan)
                            )
                            productName = ""
                            price = ""
                            valueProp = ""
                            businessAndMarketingPlan = ""
                        }
                    }
                    .disabled(productName == "" || price == "" || valueProp == "" || businessAndMarketingPlan == "")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        pendingReviewPosts.toggle()
                    } label: {
                        Image(systemName: "document.badge.clock.fill")
                    }
                }
            }
            .sheet(isPresented: $pendingReviewPosts) {
                NavigationStack {
                    List {
                        ForEach(ppManager.pendingPosts.indices, id: \.description) { i in
                            NavigationLink {
                                Form {
                                    Section("Information") {
                                        Text(ppManager.pendingPosts[i].productName)
                                        Text(ppManager.pendingPosts[i].price)
                                    }
                                    
                                    Section("Value Proposition") {
                                        Text(ppManager.pendingPosts[i].valueProp)
                                    }
                                    
                                    Section("Business and Marketing Plan") {
                                        Text(ppManager.pendingPosts[i].businessAndMarketingPlan)
                                    }
                                    
                                    Button("Retract from Review", role: .destructive) {
                                        ppManager.pendingPosts.remove(at: i)
                                        dismiss()
                                    }
                                }
                            } label: {
                                HStack {
                                    Circle()
                                        .scaledToFit()
                                        .frame(width: 12)
                                        .foregroundColor(.yellow)
                                        .padding(.horizontal, 5)
                                    VStack(alignment: .leading) {
                                        Text(ppManager.pendingPosts[i].productName)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        Text(ppManager.pendingPosts[i].valueProp)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                            .lineLimit(2)
                                    }
                                }
                            }
                        }
                        .onDelete { indexSet in
                            ppManager.pendingPosts.remove(atOffsets: indexSet)
                        }
                    }
                    .navigationTitle("Pending Posts")
                }
            }
        }
    }
}

#Preview {
    CreatePostView()
}
