//
//  ShoppingListViewController.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/02.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    private let things: [String] = ["トイレットペーパー", "マヨネーズ", "カレー"]
    

    @IBOutlet private weak var shoppingListTableView: UITableView!
    @IBOutlet private weak var addThingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupAddThingButton()
    }
    
    private func setupTableView() {
        shoppingListTableView.dataSource = self
    }
    
    private func setupAddThingButton() {
        addThingButton.layer.cornerRadius = addThingButton.bounds.height / 2
    }
    
    
    @IBAction private func addThing(_ sender: UIButton) {
        print("追加!!")
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
