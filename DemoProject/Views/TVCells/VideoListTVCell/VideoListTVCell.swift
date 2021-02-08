//
//  VideoListTVCell.swift
//  DemoProject
//
//  Created by K12 Services on 02/01/21.
//

import UIKit

class VideoListTVCell: UITableViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    var itemData : VideoListModel? {
        didSet {
            self.titleLabel.text = itemData?.title
            self.descriptionLabel.text = itemData?.description
            self.thumbnailImage.loadImageUsingCacheWithURLString(itemData?.thumb ?? "", placeHolder: UIImage(named: "placeholder")) { (bool) in
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.applyDefaultShadow()
        
        titleLabel.font = UIFont(name: "Helvetica Neue Bold", size: 17)

        descriptionLabel.font = UIFont(name: "Helvetica Neue", size: 14)
    }
}
