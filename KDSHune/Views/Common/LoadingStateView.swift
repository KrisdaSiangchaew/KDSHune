//
//  LoadingStateView.swift
//  KDSHune
//
//  Created by Kris on 30/6/2566 BE.
//

import SwiftUI

struct LoadingStateView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .foregroundColor(Color(uiColor: .secondaryLabel))
            Spacer()
        }
    }
}

struct LoadingStateView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingStateView()
    }
}
