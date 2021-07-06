//
//  ShoppingListViewController.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/02.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit
import RealmSwift

class ShoppingListViewController: UIViewController {
    
    private let reuseIdentifier = "productCell"
    private let realmManager = RealmManager()
    private var products: Results<Product>!
    

    @IBOutlet private weak var shoppingListTableView: UITableView!
    @IBOutlet private weak var addProductButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupShoppingListTableView()
        setupAddProductButton()
        writeCategoriesInRealm()
        appendProductsNotDeleted()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        shoppingListTableView.reloadData()
    }
    
    private func setupShoppingListTableView() {
        shoppingListTableView.dataSource = self
        shoppingListTableView.delegate   = self
        shoppingListTableView.register(UINib(nibName: reuseIdentifier, bundle: nil),
                                       forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func setupAddProductButton() {
        addProductButton.layer.cornerRadius = addProductButton.bounds.height / 2
    }
    
    private func transitionToCategoryVC() {
        let categoryVC = storyboard?.instantiateViewController(withIdentifier: "categoryListVC") as! CategoryListViewController
        navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    private func writeCategoriesInRealm() {
        guard let categories = realmManager.loadAllCategory() else { return }
        if categories.isEmpty {
            let categories = ["日用品", "食品", "衣服", "その他"]
            _ = categories.map {
                let category = Category()
                category.categoryName = $0
                realmManager.writeCategory(category)
            }
        }
    }
    
    private func appendProductsNotDeleted() {
        guard let products = realmManager.loadProductsNotDeleted() else { return }
        self.products = products
    }
    
    
    @IBAction private func tappedAddProductButton(_ sender: UIButton) {
        transitionToCategoryVC()
    }
    
}

extension ShoppingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let products = products else { return 0 }
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProductCell
        productCell.setupProductCell(product: products[indexPath.row])
        productCell.delegate = self
        return productCell
    }
    
}

extension ShoppingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension ShoppingListViewController: ProductCellDelegate {
    
    func remove(product: Product?) {
        guard let puroduct = product else { return }
        Alert.presentDelete(on: self, productName: puroduct.productName) { _ in
//            self.realmManager.updateThingDeleteFlag(puroduct, isDelete: true)
            DispatchQueue.main.async { self.shoppingListTableView.reloadData() }
        }
    }
    
}
