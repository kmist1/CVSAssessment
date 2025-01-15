//
//  CVSAssessmentTests.swift
//  CVSAssessmentTests
//
//  Created by krunal mistry on 1/14/25.
//

import XCTest
@testable import CVSAssessment

final class CVSAssessmentTests: XCTestCase {

    var flickrImage: FlickrImage?
    var viewModel: FlickrViewModel? = nil
    var mockService: MockFlickrAPIService!
    
    override func setUp() {
        super.setUp()
        mockService = MockFlickrAPIService()
        viewModel = FlickrViewModel(service: mockService)
        let descriptionHTML = """
         <p><a href=\"https://www.flickr.com/people/107626626@N06/">ildikoannable</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/107626626@N06/54249235448/" title="Porcupine"><img src=\"https://live.staticflickr.com/65535/54249235448_7a10b2308b_m.jpg" width="240" height="163" alt="Porcupine" /></a></p> <p>Porcupine spotted on the ground snacking on twigs.</p>
        """
        flickrImage = FlickrImage(
            title: "Porcupine",
            link: "https://www.flickr.com",
            media: FlickrMedia(mediaURL: "https://www.flickr.com/image.jpg"),
            description: descriptionHTML,
            published: "2025-01-05T23:04:10Z",
            author: "nobody@flickr.com (\"krunal mistry\")"
        )
    }
    
    override func tearDown() {
        flickrImage = nil
        mockService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testParsedAuthor() {
        XCTAssertEqual(flickrImage?.parsedAuthor, "Krunal Mistry", "Parsed author should be 'Krunal Mistry'")
    }
    
    
    func testFormattedPublishedDate() {
        XCTAssertEqual(flickrImage?.formattedPublishedDate, "Jan 5, 2025 at 11:04 pm", "Published date should be formatted correctly.")
    }
    
    func testSuccessfulResponse() async throws {
        let mockJSON = """
                {
                    "items": [
                        {
                            "title": "Porcupine",
                            "link": "https://www.flickr.com",
                            "media": { "m": "https://www.flickr.com/image.jpg" },
                            "description": "<p>Author posted a photo:</p><p>Photo description</p><p>El Dorado Lodge, Sierra Nevada de Santa Marta, Colombia</p>",
                            "published": "2025-01-05T23:04:10Z",
                            "author": "nobody@flickr.com (\\\"krunal mistry\\\")"
                        }
                    ]
                }
                """
        mockService.mockData = mockJSON.data(using: .utf8)
        mockService.mockResponseCode = 200
        
        let result = try await viewModel?.getImages(url: "https://www.flickr.com")
        XCTAssertEqual(result?.items.count, 1, "The mock response should contain 1 item.")
        XCTAssertEqual(result?.items.first?.title, "Porcupine", "The title should match the mock data.")
    }
}
