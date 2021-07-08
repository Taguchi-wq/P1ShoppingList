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

    // MARK: - @IBOutlets
    /// ショッピングリストに追加したモノを表示するUITableView
    @IBOutlet private weak var shoppingListTableView: UITableView!
    /// モノを追加するUIButton
    @IBOutlet private weak var addProductButton: UIButton!
    
    
    // MARK: - Properties
    /// NeededProductCellのidentifier
    private let neededProductCellIdentifier = "NeededProductCell"
    /// CategoryViewControllerのidentifier
    private let categoryListVCIdentifier = "categoryListVC"
    /// RealmManagerのshared
    private let realmShared = RealmManager.shared
    /// NeededProductを格納するResults
    private var neededProducts: Results<NeededProduct>!
    
    
    // MARK: - Override Methods
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
    
    
    // MARK: - Private Methods
    /// ShoppingListTableViewを設定する
    private func setupShoppingListTableView() {
        shoppingListTableView.dataSource = self
        shoppingListTableView.delegate   = self
        shoppingListTableView.register(UINib(nibName: neededProductCellIdentifier, bundle: nil),
                                       forCellReuseIdentifier: neededProductCellIdentifier)
    }
    
    /// addProductButtonを設定する
    private func setupAddProductButton() {
        addProductButton.layer.cornerRadius = addProductButton.bounds.height / 2
    }
    
    /// CategoryViewControllerに遷移する
    private func transitionToCategoryVC() {
        let categoryVC = storyboard?.instantiateViewController(withIdentifier: categoryListVCIdentifier) as! CategoryListViewController
        navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    /// Realmにカテゴリーを保存する
    private func writeCategoriesInRealm() {
        // Realmにカテゴリーがなければ書き込む。あれば何もしない。
        guard let categories = realmShared.loadAll(Category.self) else { return }
        if categories.isEmpty {
            let categories = ["日用品", "食品", "衣服", "その他"]
            _ = categories.map {
                let category = Category()
                category.categoryName = $0
                realmShared.writeCategory(category)
            }
        }
    }
    
    /// 必要なモノをneededProducts配列に追加する
    private func appendNeededProducts() {
        guard let neededProducts = realmShared.loadNeededProduct() else { return }
        self.neededProducts = neededProducts
    }
    
    
    // MARK: - @IBActions
    /// addProductButtonを押した時の処理
    @IBAction private func tappedAddProductButton(_ sender: UIButton) {
        transitionToCategoryVC()
    }
    
}


// MARK: - UITableViewDataSource
extension ShoppingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let neededProducts = neededProducts else { return 0 }
        return neededProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let neededProductCell = tableView.dequeueReusableCell(withIdentifier: neededProductCellIdentifier, for: indexPath) as! NeededProductCell
        neededProductCell.setupNeededProductCell(neededProduct: neededProducts[indexPath.row])
        neededProductCell.delegate = self
        return neededProductCell
    }
    
}


// MARK: - UITableViewDelegate
extension ShoppingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}


// MARK: - NeededProductCellDelegate
extension ShoppingListViewController: NeededProductCellDelegate {
    
    /// 必要なモノを削除する
    func remove(neededProduct: NeededProduct?) {
        guard let neededProduct = neededProduct else { return }
        guard let product = realmShared.loadByPrimaryKey(Product.self, primaryKey: neededProduct.productID) else { return }
        Alert.presentDelete(on: self, productName: product.productName) { _ in
            self.realmShared.deleteNeededProduct(neededProduct)
            DispatchQueue.main.async { self.shoppingListTableView.reloadData() }
        }
    }
    
}
