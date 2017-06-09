//
//  LogCell.swift
//  Inspiring
//
//  Created by Vu Dang on 6/8/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import UIKit

class LogCell: UITableViewCell {

    @IBOutlet weak var sequenceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with: ApacheLog) {
        sequenceLabel.text = with.threePageSequence
        countLabel.text = "\(with.count)"
    }
}
