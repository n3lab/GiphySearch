//
//  GifTableViewCell.swift
//  GiphySearch
//
//  Created by n3deep on 06.07.2020.
//  Copyright © 2020 n3deep. All rights reserved.
//

import UIKit

class GifTableViewCell: UITableViewCell {

    @IBOutlet weak var gifImageView: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.gifImageView.clear()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
