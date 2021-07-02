//
//  ThingCell.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/02.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit

class ThingCell: UITableViewCell {
    
    @IBOutlet private weak var thingLabel: UILabel!
    @IBOutlet private weak var removeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction private func remove(_ sender: UIButton) {
        print("remove")
    }
    
}
