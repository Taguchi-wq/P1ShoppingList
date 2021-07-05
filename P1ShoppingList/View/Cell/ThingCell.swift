//
//  ThingCell.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/02.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit
import RealmSwift

class ThingCell: UITableViewCell {
    
    @IBOutlet private weak var thingLabel: UILabel!
    @IBOutlet private weak var removeButton: UIButton!
    
    
    private let realmManager = RealmManager()
    private var thing: Thing?
    weak var delegate: ThingCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupRemoveButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupThingCell(thing: Thing) {
        thingLabel.text = thing.thingName
        self.thing      = thing
    }
    
    private func setupRemoveButton() {
        removeButton.layer.cornerRadius = 20
    }
    
    
    @IBAction private func tappedRemoveButton(_ sender: UIButton) {
        delegate?.remove(thing: thing)
    }
    
}

protocol ThingCellDelegate: class {
    func remove(thing: Thing?)
}
