//
//  FlickrAPIError.swift
//  CVSAssessment
//
//  Created by krunal mistry on 1/14/25.
//

import Foundation

/// Representing possible errors that can occur in the Flickr API service.
enum FlickrAPIError: Error, CustomStringConvertible {
    case badRequest
    case badResponse(statusCode: Int)
    case badURL
    case decoderError
}

extension FlickrAPIError {
    var description: String {
        switch self {
        case .badRequest:
            return "Error: Bad request"
        case .badResponse(let statusCode):
            return "Error: Bad response. Status code: \(statusCode)"
        case .badURL:
            return "Error: Bad URL"
        case .decoderError:
            return "Decoder error"
        }
    }
}
