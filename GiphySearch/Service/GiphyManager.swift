//
//  GiphyManager.swift
//  GiphySearch
//
//  Created by n3deep on 06.07.2020.
//  Copyright © 2020 n3deep. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GiphyManager {
    
    let apiKey = "PQv1Q31fhkGw6ibCenlD733LTI1mdoZt"
    let apiURL = "https://api.giphy.com/v1/gifs/search"
     
    func getGifsBySearch(searchString: String, onSuccess : @escaping  ([Gif]) -> Void, onFailed: @escaping  (String) -> Void) {
        
        let params = ["api_key": apiKey,
                          "q": searchString]

        AF.request(apiURL,
                  method: .get,
              parameters: params,
                encoding: URLEncoding.default,
                 headers: nil)
          .responseJSON { (response) in
            switch response.result {
            case .success(let json):
                //print("\n\n Success value and JSON: \(json)")
                   
                let jsonResult = JSON(json)

                var gifs: [Gif] = []
                
                let gifsData = jsonResult["data"].arrayValue
                for gifData in gifsData {

                    let gifImagesData = gifData["images"]

                    if let gifURL = URL(string: gifImagesData["fixed_height"]["url"].stringValue), let fullSizeURL = URL(string: gifImagesData["downsized_large"]["url"].stringValue) {
                        gifs.append(Gif(url: gifURL, fullSizeURL: fullSizeURL))
                    }
                }

                onSuccess(gifs)
                
            case .failure(let error):

                onFailed(error.errorDescription ?? "unknown error")
            }
        }
    }
    
    
}
