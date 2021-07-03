//
//  ShoppingListViewController.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/02.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    private let reuseIdentifier = "ThingCell"
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
        shoppingListTableView.register(UINib(nibName: reuseIdentifier, bundle: nil),
                                       forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func setupAddThingButton() {
        addThingButton.layer.cornerRadius = addThingButton.bounds.height / 2
    }
    
    private func transitionToCategoryVC() {
        let categoryVC = storyboard?.instantiateViewController(withIdentifier: "categoryListVC") as! CategoryListViewController
        navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    
    @IBAction private func addThing(_ sender: UIButton) {
        transitionToCategoryVC()
    }
    
}

extension ShoppingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return things.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let thingCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ThingCell
        thingCell.setupThingCell(thing: things[indexPath.row])
        return thingCell
    }
    
}
