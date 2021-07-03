//
//  CategoryListViewController.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/03.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit

class CategoryListViewController: UIViewController {

    @IBOutlet private weak var categoryListTableView: UITableView!
    
    
    private let identifier = "categoryCell"
    private let categories: [String] = ["食品", "日用品", "趣味"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCategoryListTableView()
    }
    
    private func setupCategoryListTableView() {
        categoryListTableView.dataSource = self
        categoryListTableView.delegate   = self
    }
    
    private func transitionToNewRegistrationVC() {
        let newRegistrationVC = storyboard?.instantiateViewController(withIdentifier: "newRegistrationVC") as! NewRegistrationViewController
        navigationController?.pushViewController(newRegistrationVC, animated: true)
    }

}


extension CategoryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        categoryCell.textLabel?.text = categories[indexPath.row]
        return categoryCell
    }
    
}

extension CategoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transitionToNewRegistrationVC()
    }
    
}
