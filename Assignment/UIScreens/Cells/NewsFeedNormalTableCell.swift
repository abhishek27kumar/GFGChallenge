//
//  NewsFeedNormalTableCell.swift
//  Assignment
//
//  Created by Abhishek on 18/08/21.
//

import UIKit

class NewsFeedNormalTableCell: UITableViewCell {

    @IBOutlet weak var vwBG: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        AppUtils.setViewRadius(view: vwBG, radius: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
