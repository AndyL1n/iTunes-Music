//
//  SearchViewModel.swift
//  iTunesMusicMain
//
//  Created by Andy on 2022/3/15.
//

import Foundation
import Alamofire

public class SearchViewModel {
    public var keyword: String = "" {
        didSet {
            keyword = keyword.replacingOccurrences(of: " ", with: "+")
        }
    }
    
    public var iTunesItems: [iTunesItem] = []
    
    
    public func startSearch(complete: @escaping (() -> Void)) {
        request(complete: { [unowned self] response in
            switch response {
            case .success(let items):
                self.iTunesItems = items
                complete()
            case .failure(let error):
                debugPrint(error.localizedDescription)
                complete()
            }
        })
    }
    
    
    private func request(complete: @escaping ((Result<([iTunesItem]), AError>) -> Void)) {
        let param : [String : String] = ["term": keyword,
                                         "attributeType": "music",
                                         "media": "music",
                                         "country": "TW"]
        
        AF.request("https://itunes.apple.com/search", method: .get, parameters: param).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode(ResponseHandler<[iTunesItem]>.self, from: data)
                    complete(.success(items.results))
                } catch _ {
                    complete(.failure(.jsonParsing))
                }
            case .failure(let error):
                complete(.failure(.custom(err: error.localizedDescription)))
            }
        }
    }
}
