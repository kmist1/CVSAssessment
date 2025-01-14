//
//  LoadingView.swift
//  CVSAssessment
//
//  Created by Krunal Mistry on 1/14/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView("Loading Images...")
                .padding()
                .accessibilityIdentifier("LoadingIndicator")
                .accessibilityHint("Flickr images are being loaded")
            Spacer()
        }
    }
}
