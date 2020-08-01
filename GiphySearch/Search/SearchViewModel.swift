//
//  SearchViewModel.swift
//  GiphySearch
//
//  Created by n3deep on 06.07.2020.
//  Copyright © 2020 n3deep. All rights reserved.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var urls: [URL]?
    
    private var gifs: [Gif]?
    
    init() {
        
        fetchGifsBySearch(Settings.defaultSearch)
    }
    
    func fetchGifsBySearch(_ searchString: String?) {
        
        var search: String = ""
        
        if searchString == "" || searchString == nil {
            search = Settings.defaultSearch
        } else {
            search = searchString!
        }
        
        print ("search: \(search)")
        let giphyManager = GiphyManager()
        giphyManager.getGifsBySearch(searchString: search, onSuccess: { gifs in
            print("ok")
            self.gifs = gifs
            self.urls = gifs.map{$0.url}
        }, onFailed: {_ in
            print ("error")
        })
    }
    
    func getFullSizeURL(row: Int) -> URL {
        
        return gifs![row].fullSizeURL
    }
}
