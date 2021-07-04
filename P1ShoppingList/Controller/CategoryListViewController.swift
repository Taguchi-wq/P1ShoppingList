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

    @IBOutlet private weak var categoryListTableView: UITableView!
    
    
    private let identifier = "categoryCell"
    private let realmManager = RealmManager()
    private var categories: Results<Category>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCategoryListTableView()
        appendCategories()
    }
    
    private func setupCategoryListTableView() {
        categoryListTableView.dataSource = self
        categoryListTableView.delegate   = self
    }
    
    private func transitionToNewRegistrationVC(indexPath: IndexPath) {
        let newRegistrationVC = storyboard?.instantiateViewController(withIdentifier: "newRegistrationVC") as! NewRegistrationViewController
        let categoryID = categories[indexPath.row].categoryID
        newRegistrationVC.setupProperties(categoryID: categoryID)
        navigationController?.pushViewController(newRegistrationVC, animated: true)
    }
    
    private func appendCategories() {
        guard let categories = realmManager.loadAllCategory() else { return }
        self.categories = categories
    }

}


extension CategoryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard categories != nil else { return 0 }
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        categoryCell.textLabel?.text = categories[indexPath.row].category
        return categoryCell
    }
    
}

extension CategoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transitionToNewRegistrationVC(indexPath: indexPath)
    }
    
}
