//
//  ProductCell.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/06.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit
import RealmSwift

class ProductCell: UITableViewCell {

    @IBOutlet private weak var registrationDateLabel: UILabel!
    @IBOutlet private weak var productLabel: UILabel!
    @IBOutlet private weak var removeButton: UIButton!
    
    
    private let realmManager = RealmManager()
    private var product: Product?
    weak var delegate: ProductCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupRemoveButton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupProductCell(product: Product) {
        productLabel.text            = product.productName
//        registrationDateLabel.text = "\(product.createdAt.month)/\(product.createdAt.day)"
        self.product                 = product
    }
    
    private func setupRemoveButton() {
        removeButton.layer.cornerRadius = 20
    }
    
    
    @IBAction private func tappedRemoveButton(_ sender: UIButton) {
        delegate?.remove(product: product)
    }
    
}

protocol ProductCellDelegate: class {
    func remove(product: Product?)
}
