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
    
    private let reuseIdentifier = "ThingCell"
    private let realmManager = RealmManager()
    private var things: Results<Thing>!
    

    @IBOutlet private weak var shoppingListTableView: UITableView!
    @IBOutlet private weak var addThingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupShoppingListTableView()
        setupAddThingButton()
        writeCategoriesInRealm()
        appendThingsNotDeleted()
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
    
    private func setupAddThingButton() {
        addThingButton.layer.cornerRadius = addThingButton.bounds.height / 2
    }
    
    private func transitionToCategoryVC() {
        let categoryVC = storyboard?.instantiateViewController(withIdentifier: "categoryListVC") as! CategoryListViewController
        navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    private func writeCategoriesInRealm() {
        guard let categories = realmManager.loadAllCategory() else { return }
        if categories.isEmpty {
            let categories = ["日用品", "食品", "衣服", "その他"]
            _ = categories.map {
                let category = Category()
                category.category = $0
                realmManager.writeCategory(category)
            }
        }
    }
    
    private func appendThingsNotDeleted() {
        guard let things = realmManager.loadThingsNotDeleted() else { return }
        self.things = things
    }
    
    
    @IBAction private func tappedAddThingButton(_ sender: UIButton) {
        transitionToCategoryVC()
    }
    
}

extension ShoppingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard things != nil else { return 0 }
        return things.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let thingCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ThingCell
        thingCell.setupThingCell(thing: things[indexPath.row])
        thingCell.delegate = self
        return thingCell
    }
    
}

extension ShoppingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension ShoppingListViewController: ThingCellDelegate {
    
    func remove(thing: Thing?) {
        guard let thing = thing else { return }
        Alert.presentDelete(on: self, thingName: thing.thingName) { _ in
            self.realmManager.updateThingDeleteFlag(thing, isDelete: true)
            DispatchQueue.main.async { self.shoppingListTableView.reloadData() }
        }
    }
    
}
