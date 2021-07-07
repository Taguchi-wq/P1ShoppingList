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

    @IBOutlet private weak var shoppingHistoryListTableView: UITableView!
    @IBOutlet private weak var inputProductTextField: UITextField!
    @IBOutlet private weak var addProductButton: UIButton!
    
    
    private let reuseIdentifier = "Cell"
    private let realmManager = RealmManager()
    private var products: Results<Product>!
    private var categoryID = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupShoppingHistoryListTableView()
        setupAddProductButton()
        appendProductsByCategoryID(categoryID)
    }
    
    func setupProperties(categoryID: String) {
        self.categoryID = categoryID
    }
    
    private func setupShoppingHistoryListTableView() {
        shoppingHistoryListTableView.dataSource = self
        shoppingHistoryListTableView.delegate   = self
    }
    
    private func setupAddProductButton() {
        addProductButton.layer.cornerRadius = addProductButton.bounds.height / 2
    }
    
    private func appendProductsByCategoryID(_ categoryID: String) {
        guard let products = realmManager.loadProductByCategoryID(categoryID) else { return }
        self.products = products
    }
    
    private func writeProductInRealm(_ productName: String) {
        let isDuplicate = realmManager.checkDuplicate(productName: productName)
        if isDuplicate {
            Alert.presentDuplicate(on: self, productName: productName)
        } else {
            let product = Product()
            product.categoryID = categoryID
            product.productName = productName
            realmManager.writeProduct(product)
            
            let neededProduct = NeededProduct()
            neededProduct.productID = product.productID
            realmManager.writeNeededProduct(neededProduct)
        }
    }

    
    @IBAction private func tappedAddProductButton(_ sender: UIButton) {
        let productIsEmpty = inputProductTextField.text?.isEmpty ?? false
        if productIsEmpty {
            Alert.presentPleaseWrite(on: self)
        } else {
            let productName = inputProductTextField.text!
            writeProductInRealm(productName)
            inputProductTextField.text = String()
            Alert.presentAdd(on: self, productName: productName, handler: nil)
            shoppingHistoryListTableView.reloadData()
        }
    }
}

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

extension NewRegistrationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        Alert.presentAdd(on: self, productName: product.productName) { _ in
//            self.realmManager.updateThingDeleteFlag(product, isDelete: false)
        }
    }
    
}
