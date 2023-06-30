//
//  ErrorStateView.swift
//  KDSHune
//
//  Created by Kris on 30/6/2566 BE.
//

import SwiftUI

struct ErrorStateView: View {
    let error: String
    var retryCallback: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 16) {
                Text(error)
                    .font(.headline)
                    .foregroundColor(Color(uiColor: .secondaryLabel))
                if let retryCallback {
                    Button("Retry", action: retryCallback)
                        .buttonStyle(.borderedProminent)
                }
            }
            Spacer()
        }
        .padding(64)
    }
}

struct ErrorStateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ErrorStateView(error: "An Error Occurred") {}
                .previewDisplayName("With callback")
            ErrorStateView(error: "An Error Occurred")
                .previewDisplayName("Without callback")
        }
    }
}
