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
    
    @State var isActive = false
    
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("email", store: .standard) private var email = ""
    
    @ObservedObject var ppManager: PendingPostManager = .shared
        
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
                                Post(email: email,
                                     productName: productName,
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
            .scrollDismissesKeyboard(.interactively)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        pendingReviewPosts.toggle()
                    } label: {
                        Image(systemName: "doc.badge.clock.fill")
                    }
                }
            }
            .sheet(isPresented: $pendingReviewPosts) {
                NavigationStack {
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
                                    
                                    Button("Retract from Review", role: .destructive) {
                                        ppManager.pendingPosts.removeAll(where: { $0 == pendingPost})
                                        dismiss.callAsFunction()
                                        isActive = false
                                    }
                                }
                                .navigationBarTitleDisplayMode(.inline)
                            } label: {
                                HStack {
                                    Circle()
                                        .scaledToFit()
                                        .frame(width: 12)
                                        .foregroundColor(.yellow)
                                        .padding(.horizontal, 5)
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
