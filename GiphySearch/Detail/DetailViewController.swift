//
//  DetailViewController.swift
//  GiphySearch
//
//  Created by n3deep on 06.07.2020.
//  Copyright © 2020 n3deep. All rights reserved.
//

import UIKit
import SwiftyGif

class DetailViewController: UIViewController {

    @IBOutlet weak var gifImageView: UIImageView!
    
    var path: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("path: \(path)")
        
        if let path = self.path {
            
            let loader = UIActivityIndicatorView.init(style: .medium)
            self.gifImageView.setGifFromURL(path, loopCount: -1, customLoader: loader)
        }
    }
}
