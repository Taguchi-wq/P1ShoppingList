//
//  NewRegistrationViewController.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/03.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit
import RealmSwift

class NewRegistrationViewController: UIViewController {

    // MARK: - @IBOutlets
    /// 今まで登録したモノを表示するUITableView
    @IBOutlet private weak var shoppingHistoryListTableView: UITableView!
    /// モノの名前を入力するUITextField
    @IBOutlet private weak var inputProductTextField: UITextField!
    /// モノをRealmに追加するUIButton
    @IBOutlet private weak var addProductButton: UIButton!
    
    
    // MARK: - Properties
    /// tableViewCellのidentifier
    private let reuseIdentifier = "Cell"
    /// RealmManagerのshared
    private let realmShared = RealmManager.shared
    /// モノを格納するResults
    private var products: Results<Product>!
    /// カテゴリーID
    private var categoryID = String()
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupShoppingHistoryListTableView()
        setupAddProductButton()
        appendProductsByCategoryID(categoryID)
    }
    
    
    // MARK: - Methods
    /// NewRegistrationViewControllerのプロパティーを設定する
    func setupProperties(categoryID: String) {
        self.categoryID = categoryID
    }
    
    
    // MARK: - Private Methods
    /// shoppingHistoryListTableViewを設定する
    private func setupShoppingHistoryListTableView() {
        shoppingHistoryListTableView.dataSource = self
        shoppingHistoryListTableView.delegate   = self
    }
    
    /// addProductButtonの設定をする
    private func setupAddProductButton() {
        addProductButton.layer.cornerRadius = addProductButton.bounds.height / 2
    }
    
    /// カテゴリーで絞りこんだモノをproducts配列に追加する
    private func appendProductsByCategoryID(_ categoryID: String) {
        guard let products = realmShared.loadProductByCategoryID(categoryID) else { return }
        self.products = products
    }
    
    /// モノをRealmに保存する
    private func writeProductInRealm(_ productName: String) {
        // 同じ名前のモノがあるかどうか確認
        let isDuplicate = realmShared.checkDuplicate(productName: productName)
        if isDuplicate {
            Alert.presentDuplicate(on: self, productName: productName)
        } else {
            let product = Product()
            product.categoryID = categoryID
            product.productName = productName
            realmShared.writeProduct(product)
            
            let neededProduct = NeededProduct()
            neededProduct.productID = product.productID
            realmShared.writeNeededProduct(neededProduct)
        }
    }

    
    // MARK: - @IBActions
    /// addProductButtonを押した時の処理
    @IBAction private func tappedAddProductButton(_ sender: UIButton) {
        // inputProductTextFieldが空かどうか確認
        let productIsEmpty = inputProductTextField.text?.isEmpty ?? false
        if productIsEmpty {
            Alert.presentPleaseWrite(on: self)
        } else {
            let productName = inputProductTextField.text!
            writeProductInRealm(productName)
            inputProductTextField.text = String()
            Alert.presentAdd(on: self, productName: productName)
            shoppingHistoryListTableView.reloadData()
        }
    }
}


// MARK: - UITableViewDataSource
extension NewRegistrationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let products = products else { return 0 }
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        productCell.textLabel?.text = products[indexPath.row].productName
        return productCell
    }
    
}


// MARK: - UITableViewDelegate
extension NewRegistrationViewController: UITableViewDelegate {
    
    // ショッピングリストに選択したモノを追加する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        // productIDからneededProduntを取得
        guard let neededProduct = self.realmShared.loadNeededProductByProductID(product.productID) else { return }
        // ショッピングリストに選択したモノが削除されているどうかを確認する
        let isDeleted = realmShared.checkDeleted(neededProduct: neededProduct)
        if isDeleted {
            // 削除されていたらショッピングリストに追加する
            let neededProduct = NeededProduct()
            neededProduct.productID = product.productID
            self.realmShared.writeNeededProduct(neededProduct)
            Alert.presentAdd(on: self, productName: product.productName)
        } else {
            // まだあるなら重複を促すアラートを出す
            Alert.presentDuplicateNeededProduct(on: self, productName: product.productName)
        }
    }
    
}
