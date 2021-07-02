//
//  ShoppingListViewController.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/02.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController {

    @IBOutlet private weak var shoppingListTableView: UITableView!
    
    private let things: [String] = ["トイレットペーパー", "マヨネーズ", "カレー"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        shoppingListTableView.dataSource = self
    }
    
}

extension ShoppingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return things.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = things[indexPath.row]
        return cell
    }
    
}
