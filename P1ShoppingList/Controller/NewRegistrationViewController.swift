//
//  NewRegistrationViewController.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/03.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit
import RealmSwift

class NewRegistrationViewController: UIViewController {

    @IBOutlet private weak var shoppingHistoryListTableView: UITableView!
    @IBOutlet private weak var thingTextField: UITextField!
    @IBOutlet private weak var categoryTextField: UITextField!
    @IBOutlet private weak var addThingButton: UIButton!
    
    
    private let reuseIdentifier = "ThingCell"
    private let realmManager = RealmManager()
    private var things: Results<Thing>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupShoppingHistoryListTableView()
        setupAddThingButton()
        appendThings()
    }
    
    private func setupShoppingHistoryListTableView() {
        shoppingHistoryListTableView.dataSource = self
        shoppingHistoryListTableView.register(UINib(nibName: reuseIdentifier, bundle: nil),
                                             forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func setupAddThingButton() {
        addThingButton.layer.cornerRadius = addThingButton.bounds.height / 2
    }
    
    private func appendThings() {
        things = realmManager.loadAllThing()
    }

}

extension NewRegistrationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard things != nil else { return 0 }
        return things.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let thingCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ThingCell
        thingCell.setupThingCell(thing: things[indexPath.row].thingName)
        return thingCell
    }
    
}
