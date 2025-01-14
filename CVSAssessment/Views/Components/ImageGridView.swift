//
//  ImageGridView.swift
//  CVSAssessment
//
//  Created by Krunal Mistry on 1/14/25.
//

import SwiftUI

struct ImageGridView: View {
    var images: [FlickrImage]
    var namespace: Namespace.ID
    var columns: [GridItem]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(images, id: \.link) { flickrImage in
                    NavigationLink(
                        destination: ImageDetailsView(
                            flickrImage: flickrImage,
                            animationNamespace: namespace
                        )
                    ) {
                        AsyncImage(url: URL(string: flickrImage.media.mediaURL)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .matchedGeometryEffect(id: flickrImage.media.mediaURL, in: namespace)
                                .transition(.opacity.animation(.easeInOut(duration: 0.4)))
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .accessibilityLabel("Image by \(flickrImage.parsedAuthor)")
                    .accessibilityHint("Tap to see more details about this image")
                }
            }
            .padding(10)
        }
    }
}
