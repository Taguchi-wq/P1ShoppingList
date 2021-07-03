//
//  NewRegistrationViewController.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/03.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit

class NewRegistrationViewController: UIViewController {

    @IBOutlet private weak var shoppingHistoryListTableView: UITableView!
    @IBOutlet private weak var thingTextField: UITextField!
    @IBOutlet private weak var categoryTextField: UITextField!
    @IBOutlet private weak var addThingButton: UIButton!
    
    
    private let reuseIdentifier = "ThingCell"
    private let things: [String] = ["トイレットペーパー", "マヨネーズ", "カレー"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupShoppingHistoryListTableView()
        setupAddThingButton()
    }
    
    private func setupShoppingHistoryListTableView() {
        shoppingHistoryListTableView.dataSource = self
        shoppingHistoryListTableView.register(UINib(nibName: reuseIdentifier, bundle: nil),
                                             forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func setupAddThingButton() {
        addThingButton.layer.cornerRadius = addThingButton.bounds.height / 2
    }

}

extension NewRegistrationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return things.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let thingCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ThingCell
        thingCell.setupThingCell(thing: things[indexPath.row])
        return thingCell
    }
    
}
