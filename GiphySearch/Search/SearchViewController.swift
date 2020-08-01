//
//  ViewController.swift
//  GiphySearch
//
//  Created by n3deep on 06.07.2020.
//  Copyright © 2020 n3deep. All rights reserved.
//

import UIKit
import Combine
import SwiftyGif

class SearchViewController: UIViewController {

    @IBOutlet weak var gifsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: SearchViewModel?
    var urls: [URL]?
    
    let gifTableViewCellIdentifier = "GifTableViewCell"
    let detailSegueIdentifier = "ShowDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gifsTableView.register(GifTableViewCell.self, forCellReuseIdentifier: gifTableViewCellIdentifier)
        
        gifsTableView.delegate = self
        gifsTableView.dataSource = self
        
        let nib = UINib(nibName: gifTableViewCellIdentifier, bundle: nil)
        gifsTableView.register(nib, forCellReuseIdentifier: gifTableViewCellIdentifier)
        
        searchBar.delegate = self
        
        viewModel = SearchViewModel()

        binding()
    }
    
    //binding
    
    func binding() {
        
        viewModel?.$urls.sink(receiveValue: {[weak self] urls in
            print("changed")
            self?.urls = urls
            self?.gifsTableView.reloadData()
            }
        ).store(in: &cancellable)
        
        
    }
    private var cancellable = Set<AnyCancellable>()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailController = segue.destination as? DetailViewController {
            let indexPath = gifsTableView.indexPathForSelectedRow
            detailController.path = viewModel?.getFullSizeURL(row: indexPath!.row)
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: detailSegueIdentifier, sender: nil)
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return urls?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard (urls != nil) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: gifTableViewCellIdentifier, for: indexPath) as! GifTableViewCell
        
        cell.selectionStyle = .none

        let loader = UIActivityIndicatorView(style: .medium)
        cell.gifImageView.setGifFromURL(urls![indexPath.row], loopCount: -1, customLoader: loader)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 230
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        viewModel?.fetchGifsBySearch(searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        viewModel?.fetchGifsBySearch(nil)
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == 0 {
            viewModel?.fetchGifsBySearch(nil)
        }
    }
}

