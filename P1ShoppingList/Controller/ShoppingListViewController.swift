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
    
    private let reuseIdentifier = "NeededProductCell"
    private let realmShared = RealmManager.shared
    private var neededProducts: Results<NeededProduct>!
    

    @IBOutlet private weak var shoppingListTableView: UITableView!
    @IBOutlet private weak var addProductButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupShoppingListTableView()
        setupAddProductButton()
        writeCategoriesInRealm()
        appendNeededProducts()
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
        guard let categories = realmShared.loadAllCategory() else { return }
        if categories.isEmpty {
            let categories = ["日用品", "食品", "衣服", "その他"]
            _ = categories.map {
                let category = Category()
                category.categoryName = $0
                realmShared.writeCategory(category)
            }
        }
    }
    
    private func appendNeededProducts() {
        guard let neededProducts = realmShared.loadNeededProduct() else { return }
        self.neededProducts = neededProducts
    }
    
    
    @IBAction private func tappedAddProductButton(_ sender: UIButton) {
        transitionToCategoryVC()
    }
    
}

extension ShoppingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let neededProducts = neededProducts else { return 0 }
        return neededProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let neededProductCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NeededProductCell
        neededProductCell.setupNeededProductCell(neededProduct: neededProducts[indexPath.row])
        neededProductCell.delegate = self
        return neededProductCell
    }
    
}

extension ShoppingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension ShoppingListViewController: NeededProductCellDelegate {
    
    func remove(neededProduct: NeededProduct?) {
        guard let neededProduct = neededProduct else { return }
        guard let product = realmShared.loadProductByPrimaryKey(neededProduct.productID) else { return }
        Alert.presentDelete(on: self, productName: product.productName) { _ in
            self.realmShared.deleteNeededProduct(neededProduct)
            DispatchQueue.main.async { self.shoppingListTableView.reloadData() }
        }
    }
    
}
