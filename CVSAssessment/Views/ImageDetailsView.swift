//
//  ImageDetailsView.swift
//  CVSAssessment
//
//  Created by krunal mistry on 1/14/25.
//

import SwiftUI

/// A reusable view for displaying an image with animation and accessibility support.
struct ImageView: View {
    let imageURL: String
    let title: String
    let author: String
    let animationNamespace: Namespace.ID
    let link: String

    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { image in
            image
                .resizable()
                .scaledToFit()
                .matchedGeometryEffect(id: link, in: animationNamespace)
                .transition(.opacity.animation(.easeInOut(duration: 0.4)))
        } placeholder: {
            ProgressView()
        }
        .frame(maxWidth: .infinity)
        .accessibilityLabel("Image titled \(title) by \(author)")
    }
}

/// A reusable view for displaying metadata (title, author, description, published date).
struct MetadataView: View {
    let flickrImage: FlickrImage
    let isCompact: Bool

    var body: some View {
        if isCompact {
            VStack(alignment: .leading, spacing: 8) {
                Text("Title: \(flickrImage.title)")
                    .font(.headline)
                    .dynamicTypeSize(.medium ... .xxLarge)
                    .accessibilityLabel("Title: \(flickrImage.title)")

                Text("Description:")
                    .font(.headline)
                    .dynamicTypeSize(.medium ... .xxLarge)
                    .accessibilityLabel("Description")

                Text(flickrImage.parsedDescription)
                    .font(.body)
                    .dynamicTypeSize(.medium ... .xxLarge)
                    .accessibilityLabel(flickrImage.parsedDescription)

                Text("Author: \(flickrImage.parsedAuthor)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .dynamicTypeSize(.medium ... .xxLarge)
                    .accessibilityLabel("Author: \(flickrImage.parsedAuthor)")

                Text("Published: \(flickrImage.formattedPublishedDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .dynamicTypeSize(.medium ... .xxLarge)
                    .accessibilityLabel("Published on \(flickrImage.formattedPublishedDate)")
            }
        } else {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title: \(flickrImage.title)")
                        .font(.headline)
                        .dynamicTypeSize(.medium ... .xxLarge)
                        .accessibilityLabel("Title: \(flickrImage.title)")

                    Text("Author: \(flickrImage.parsedAuthor)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .dynamicTypeSize(.medium ... .xxLarge)
                        .accessibilityLabel("Author: \(flickrImage.parsedAuthor)")
                }

                Spacer()

                Text("Published: \(flickrImage.formattedPublishedDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .dynamicTypeSize(.medium ... .xxLarge)
                    .accessibilityLabel("Published on \(flickrImage.formattedPublishedDate)")
            }
        }
    }
}

/// A reusable view for displaying dimensions of the image.
struct DimensionsView: View {
    let width: Int?
    let height: Int?

    var body: some View {
        if let width = width, let height = height {
            Text("Dimensions: \(width) x \(height)")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .dynamicTypeSize(.medium ... .xxLarge)
                .accessibilityLabel("Image dimensions are \(width) pixels wide and \(height) pixels high")
        } else {
            Text("Dimensions: Unknown")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .dynamicTypeSize(.medium ... .xxLarge)
                .accessibilityLabel("Image dimensions are not available")
        }
    }
}

/// A reusable view for sharing image details.
struct ShareImageView: View {
    let shareContent: String

    var body: some View {
        ShareLink(item: shareContent) {
            Label("Share Image", systemImage: "square.and.arrow.up")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .accessibilityLabel("Share Image")
        .accessibilityHint("Shares the image and its details")
    }
}

/// Main ImageDetailsView using reusable components.
struct ImageDetailsView: View {
    let flickrImage: FlickrImage
    let animationNamespace: Namespace.ID
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Image view
                ImageView(
                    imageURL: flickrImage.media.mediaURL,
                    title: flickrImage.title,
                    author: flickrImage.parsedAuthor,
                    animationNamespace: animationNamespace,
                    link: flickrImage.link
                )

                // Metadata view
                MetadataView(flickrImage: flickrImage, isCompact: horizontalSizeClass == .compact)

                // Dimensions view
                DimensionsView(width: flickrImage.dimensions.width, height: flickrImage.dimensions.height)

                Spacer()

                // Share image view
                ShareImageView(shareContent: createShareContent())
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityElement(children: .contain)
    }

    private func createShareContent() -> String {
        """
        Title: \(flickrImage.title)
        Author: \(flickrImage.parsedAuthor)
        Published: \(flickrImage.formattedPublishedDate)
        Description: \(flickrImage.parsedDescription)
        Image: \(flickrImage.media.mediaURL)
        """
    }
}

