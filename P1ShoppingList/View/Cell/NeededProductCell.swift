//
//  NeededProductCell.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/07.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit
import RealmSwift

class NeededProductCell: UITableViewCell {
    
    @IBOutlet private weak var registrationDateLabel: UILabel!
    @IBOutlet private weak var neededProductLabel: UILabel!
    @IBOutlet private weak var removeButton: UIButton!
    
    
    private let realmManager = RealmManager()
    private var neededProduct: NeededProduct?
    weak var delegate: NeededProductCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupRemoveButton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupNeededProductCell(neededProduct: NeededProduct) {
        neededProductLabel.text    = realmManager.loadProductByPrimaryKey(neededProduct.productID)?.productName
        registrationDateLabel.text = "\(neededProduct.registrationDate.month)/\(neededProduct.registrationDate.day)"
        self.neededProduct         = neededProduct
    }
    
    private func setupRemoveButton() {
        removeButton.layer.cornerRadius = 20
    }
    
    
    @IBAction private func tappedRemoveButton(_ sender: UIButton) {
        //        delegate?.remove(product: Product)
    }
    
}

protocol NeededProductCellDelegate: class {
    func remove(product: Product?)
}
