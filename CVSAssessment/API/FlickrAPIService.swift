//
//  FlickrAPIService.swift
//  CVSAssessment
//
//  Created by krunal mistry on 1/14/25.
//

import Foundation

// Protocol defining the contract for a Flickr API Service.
protocol FlickrAPIServiceProtocol {
    var error: FlickrAPIError? { get set }

    /// Fetches and decodes data from a given URL string.
      /// - Parameters:
      ///   - urlString: The URL string to fetch flickr data from.
      ///   - dataType: The type to decode the fetched data into. Must conform to `Decodable`.
      /// - Returns: A decoded object of the specified type.
      /// - Throws: An error if the URL is invalid, the request fails, or decoding fails.
    func getFlickrData<T: Decodable>(urlString: String, dataType: T.Type) async throws -> T
}

// To provide helper methods.
extension FlickrAPIServiceProtocol {

    /// Determines the API error from the given response.
    /// - Parameter response: The `URLResponse` object from an API call.
    /// - Returns: An `FlickrAPIError` if an error is identified.
    func apiError(from response: URLResponse) -> FlickrAPIError? {
        guard let urlResponse = response as? HTTPURLResponse else { return .badRequest }
        
        switch urlResponse.statusCode {
        case 200..<300:
            return nil
        default:
            return .badResponse(statusCode: urlResponse.statusCode)
        }
    }
}

// A service class responsible for making API calls to the Flickr API.
/// Implements the `FlickrAPIServiceProtocol`.
final class FlickrAPIService: FlickrAPIServiceProtocol {
    
    var error: FlickrAPIError?
    
    private init() {}
    static let shared = FlickrAPIService()

    func getFlickrData<T: Decodable>(urlString: String, dataType: T.Type) async throws -> T where T : Decodable {
        
        guard let url = URL(string: urlString) else {
            print("Flickr API Error: Invalid URL - \(urlString)")
            throw FlickrAPIError.badURL
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Flickr API Error: Unable to cast response to HTTPURLResponse")
                throw FlickrAPIError.badResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                print("Successfully decoded data: \(decodedData)")
                return decodedData
            } catch {
                print("Flickr API Error: Decoding failed - \(error.localizedDescription)")
                throw FlickrAPIError.decoderError
            }
        } catch {
            print("Flickr API Error: Request failed - \(error.localizedDescription)")
            throw FlickrAPIError.badRequest
        }
    }
}
