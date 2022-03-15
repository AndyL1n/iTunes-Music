//
//  iTunesItem.swift
//  iTunesMusicMain
//
//  Created by Andy on 2022/3/15.
//

import Foundation
import UIKit
import Kingfisher

public struct ResponseHandler<T>: Codable where T: Codable {
    let resultCount: Int
    let results: T
}

public struct iTunesItem: Codable {
    @Default<Empty> public var wrapperType: String
    @Default<Empty> public var kind: String
    @Default<Zero> public var artistId: Int
    @Default<Zero> public var collectionId: Int
    @Default<Zero> public var trackId: Int
    @Default<Empty> public var artistName: String
    @Default<Empty> public var collectionName: String
    @Default<Empty> public var trackName: String
    @Default<Empty> public var collectionCensoredName: String
    @Default<Empty> public var trackCensoredName: String
    @Default<Empty> public var artistViewUrl: String
    @Default<Empty> public var collectionViewUrl: String
    @Default<Empty> public var trackViewUrl: String
    @Default<Empty> public var previewUrl: String
    @Default<Empty> public var artworkUrl30: String
    @Default<Empty> public var artworkUrl60: String
    @Default<Empty> public var artworkUrl100: String
    @Default<ZeroDouble> public var collectionPrice: Double
    @Default<ZeroDouble> public var trackPrice: Double
    @Default<Empty> public var releaseDate: String
    @Default<Empty> public var collectionExplicitness: String
    @Default<Empty> public var trackExplicitness: String
    @Default<Zero> public var discCount: Int
    @Default<Zero> public var discNumber: Int
    @Default<Zero> public var trackCount: Int
    @Default<Zero> public var trackNumber: Int
    @Default<Zero> public var trackTimeMillis: Int
    @Default<Empty> public var country: String
    @Default<Empty> public var currency: String
    @Default<Empty> public var primaryGenreName: String
    @Default<False> public var isStreamable: Bool
    @Default<Zero> public var collectionArtistId: Int
    @Default<Empty> public var collectionArtistViewUrl: String
    @Default<ZeroDouble> public var trackRentalPrice: Double
    @Default<ZeroDouble> public var collectionHdPrice: Double
    @Default<ZeroDouble> public var trackHdPrice: Double
    @Default<ZeroDouble> public var trackHdRentalPrice: Double
    @Default<Empty> public var contentAdvisoryRating: String
    @Default<Empty> public var shortDescription: String
    @Default<Empty> public var longDescription: String
    @Default<False> public var hasITunesExtras: Bool
    @Default<Empty> public var collectionArtistName: String

}
