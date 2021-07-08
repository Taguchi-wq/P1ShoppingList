//
//  CategoryListViewController.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/03.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryListViewController: UIViewController {

    // MARK: - @IBOutlets
    /// カテゴリーを表示するUITableView
    @IBOutlet private weak var categoryListTableView: UITableView!
    
    
    // MARK: - Properties
    /// CategoryCellのidentifier
    private let categoryCellIdentifier = "categoryCell"
    /// NewRegistrationViewControllerのidentifier
    private let newRegistrationVCIdentifier = "newRegistrationVC"
    /// RealmManagerのshared
    private let realmShared = RealmManager.shared
    /// カテゴリーを格納するResults
    private var categories: Results<Category>!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCategoryListTableView()
        appendCategories()
    }
    
    
    // MARK: - Private Methods
    /// CategoryListTableViewを設定する
    private func setupCategoryListTableView() {
        categoryListTableView.dataSource = self
        categoryListTableView.delegate   = self
    }
    
    /// NewRegistrationViewControllerに遷移する
    private func transitionToNewRegistrationVC(indexPath: IndexPath) {
        let newRegistrationVC = storyboard?.instantiateViewController(withIdentifier: newRegistrationVCIdentifier) as! NewRegistrationViewController
        let categoryID = categories[indexPath.row].categoryID
        newRegistrationVC.setupProperties(categoryID: categoryID)
        navigationController?.pushViewController(newRegistrationVC, animated: true)
    }
    
    /// カテゴリーを配列に追加する
    private func appendCategories() {
        guard let categories = realmShared.loadAll(Category.self) else { return }
        self.categories = categories
    }

}


// MARK: - UITableViewDataSource
extension CategoryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let categories = categories else { return 0 }
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: categoryCellIdentifier, for: indexPath)
        categoryCell.textLabel?.text = categories[indexPath.row].categoryName
        return categoryCell
    }
    
}


// MARK: - UITableViewDelegate
extension CategoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transitionToNewRegistrationVC(indexPath: indexPath)
    }
    
}
