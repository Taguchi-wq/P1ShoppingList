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
    
    // MARK: - @IBOutlets
    /// 登録日を表示するUILabel
    @IBOutlet private weak var registrationDateLabel: UILabel!
    /// 必要なモノを表示するUILabel
    @IBOutlet private weak var neededProductLabel: UILabel!
    /// 削除ボタン
    @IBOutlet private weak var removeButton: UIButton!
    
    
    // MARK: - Properties
    /// RealmManagerのshared
    private let realmShared = RealmManager.shared
    /// 必要なモノ
    private var neededProduct: NeededProduct?
    /// NeededProductCellのdelegate
    weak var delegate: NeededProductCellDelegate?
    
    
    // MARK: - Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupRemoveButton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: - Methods
    /// NeededProductCellの設定をする
    func setupNeededProductCell(neededProduct: NeededProduct) {
        neededProductLabel.text    = realmShared.loadByPrimaryKey(Product.self, primaryKey: neededProduct.productID)?.productName
        registrationDateLabel.text = "\(neededProduct.registrationDate.month)/\(neededProduct.registrationDate.day)"
        self.neededProduct         = neededProduct
    }
    
    
    // MARK: - Private Methods
    /// 削除ボタンの設定をする
    private func setupRemoveButton() {
        removeButton.layer.cornerRadius = 20
    }
    
    
    // MRAK: - @IBActions
    /// 削除ボタンを押した時の処理
    @IBAction private func tappedRemoveButton(_ sender: UIButton) {
        delegate?.remove(neededProduct: neededProduct)
    }
    
}


// MARK: - NeededProductCellDelegate
protocol NeededProductCellDelegate: class {
    func remove(neededProduct: NeededProduct?)
}
