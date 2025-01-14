//
//  FlickrDataModel.swift
//  CVSAssessment
//
//  Created by krunal mistry on 1/14/25.
//

import Foundation

// Representing the response from the Flickr API.
struct FlickrResponse: Codable {
    let items: [FlickrImage]
}

// Representing an individual image item in the Flickr API response.
struct FlickrImage: Codable {
    let title: String
    let link: String
    let media: FlickrMedia
    let description: String
    let published: String
    let author: String

    /// Computed property to parse the dimensions (width and height) of the image from the `description`.
    var dimensions: (width: Int?, height: Int?) {
        parseDimensions(from: description)
    }

    /// Computed property to extract and capitalize the author's name from the `author` field.
    var parsedAuthor: String {
        let regex = try? NSRegularExpression(pattern: "\\(\"(.*?)\"\\)")
        if let match = regex?.firstMatch(in: author, range: NSRange(author.startIndex..., in: author)),
           let range = Range(match.range(at: 1), in: author) {
            return author[range].capitalized
        }
        return "Unknown Author"
    }

    /// Computed property to extract and clean the main description from the `description` HTML.
    var parsedDescription: String {
        let regex = try? NSRegularExpression(pattern: "<p>(.*?)<\\/p>")
        if let matches = regex?.matches(in: description, range: NSRange(description.startIndex..., in: description)),
           matches.count >= 3,
           let range = Range(matches[2].range(at: 1), in: description) {
            return description[range].trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return "No Description"
    }

    /// Computed property to format the published date into a user-friendly string.
    var formattedPublishedDate: String {
        let isoDateFormatter = ISO8601DateFormatter()      
        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "MMM d, yyyy 'at' h:mm a"
        displayDateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        if let date = isoDateFormatter.date(from: published) {
            return displayDateFormatter.string(from: date)
        }
        return "Unknown Date"
    }

    /// Parses the width and height of the image from the description.
       /// - Parameter description: The HTML description of the image.
       /// - Returns: A tuple containing the width and height as optional integers.
    func parseDimensions(from description: String) -> (width: Int?, height: Int?) {
        let widthRegex = #"width\s*=\s*['"](\d+)['"]"#
        let heightRegex = #"height\s*=\s*['"](\d+)['"]"#
        
        let width = description.matchingFirstGroup(using: widthRegex).flatMap { Int($0) }
        let height = description.matchingFirstGroup(using: heightRegex).flatMap { Int($0) }
        
        return (width, height)
    }
}

/// Representing the media content of a Flickr image.
struct FlickrMedia: Codable {
    let mediaURL: String
    
    enum CodingKeys: String, CodingKey {
        case mediaURL = "m"
    }
}
