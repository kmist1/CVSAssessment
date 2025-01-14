//
//  FlickrViewModel.swift
//  CVSAssessment
//
//  Created by krunal mistry on 1/14/25.
//

import Foundation

/// Protocol defining the contract for a Flickr ViewModel.
protocol FlickrViewModelProtocol {
    var flickrResponse: FlickrResponse? { get set }


    /// Fetches images from a specified URL.
    /// - Parameter url: The URL to fetch the images from.
    /// - Returns: A `FlickrResponse` object containing the fetched images, or `nil` if the fetch fails.
    /// - Throws: An error if the data retrieval or decoding fails.
    func getImages(url: String) async throws -> FlickrResponse?
}

/// A FlickrViewModel class responsible for managing Flickr data.
final class FlickrViewModel {
    var flickrResponse: FlickrResponse?
    let apiServiceProtocol: FlickrAPIServiceProtocol

    init(service: FlickrAPIServiceProtocol) {
        self.apiServiceProtocol = service
    }
}

// Implement the `getImages` method.
extension FlickrViewModel: FlickrViewModelProtocol {
    func getImages(url: String) async throws -> FlickrResponse? {
        let data = try await apiServiceProtocol.getFlickrData(urlString: url, dataType: FlickrResponse.self)
        self.flickrResponse = data
        return data
    }
}
