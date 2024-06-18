//
//  OnboardingView.swift
//  Connectify
//
//  Created by Tristan Chay on 18/6/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Welcome to Connectify")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            item(icon: "person.badge.key.fill", title: "Connect and Invest", description: "Connectify allows student entrepreneurs to reach out and connect with Investors.")
            item(icon: "checkmark.arrow.trianglehead.counterclockwise", title: "Reviewed and Verified", description: "Every single product posted in Connectify has been reviewed by our staff or investors to ensure that it is of good quality.")
            item(icon: "dollarsign.arrow.trianglehead.counterclockwise.rotate.90", title: "Trusted Investors", description: "Investors on Connectify have been vetted and are only allowed onto the app on an invite-only basis.")
            Spacer()
            Button {
                dismiss()
            } label: {
                Text("Continue")
                    .padding(10)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 30)
            .buttonStyle(.borderedProminent)
        }
        .padding(.top, 30)
    }
    
    func item(icon: String, title: String, description: String) -> some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.accentColor)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            }
            .padding(.leading, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 30)
        .padding(.vertical)
    }
}

#Preview {
    OnboardingView()
}
