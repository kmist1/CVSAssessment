//
//  MockAPIService.swift
//  CVSAssessment
//
//  Created by krunal mistry on 1/14/25.
//

import Foundation

// A mock implementation of `FlickrAPIServiceProtocol` for testing purposes.
/// This class allows injecting mock data and response codes to simulate various API scenarios.
final class MockFlickrAPIService: FlickrAPIServiceProtocol {
    var error: FlickrAPIError?
    var mockData: Data?
    var mockResponseCode: Int?

    func getFlickrData<T: Decodable>(urlString: String, dataType: T.Type) async throws -> T {
        if let responseCode = mockResponseCode, !(200..<300).contains(responseCode) {
            throw FlickrAPIError.badResponse(statusCode: responseCode)
        }
    
        guard let mockData = mockData else {
            throw FlickrAPIError.badRequest
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: mockData)
            return decodedData
        } catch {
            throw FlickrAPIError.decoderError
        }
    }
}
