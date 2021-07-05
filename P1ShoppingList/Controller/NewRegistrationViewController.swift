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
    @IBOutlet private weak var addThingButton: UIButton!
    
    
    private let reuseIdentifier = "Cell"
    private let realmManager = RealmManager()
    private var things: Results<Thing>!
    private var categoryID = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupShoppingHistoryListTableView()
        setupAddThingButton()
        appendThingsByCategoryID(categoryID)
    }
    
    func setupProperties(categoryID: String) {
        self.categoryID = categoryID
    }
    
    private func setupShoppingHistoryListTableView() {
        shoppingHistoryListTableView.dataSource = self
        shoppingHistoryListTableView.delegate   = self
    }
    
    private func setupAddThingButton() {
        addThingButton.layer.cornerRadius = addThingButton.bounds.height / 2
    }
    
    private func appendThingsByCategoryID(_ categoryID: String) {
        guard let things = realmManager.loadThingByCategoryID(categoryID) else { return }
        self.things = things
    }
    
    private func writeThingInRealm(_ thingName: String) {
        let isDuplicate = realmManager.checkDuplicate(thingName: thingName)
        if isDuplicate {
            Alert.presentDuplicate(on: self, thingName: thingName)
        } else {
            let thing = Thing()
            thing.categoryID = categoryID
            thing.thingName = thingName
            realmManager.writeThing(thing)
        }
    }

    
    @IBAction private func tappedAddThingButton(_ sender: UIButton) {
        let thingIsEmpty = thingTextField.text?.isEmpty ?? false
        if thingIsEmpty {
            Alert.presentPleaseWrite(on: self)
        } else {
            let thing = thingTextField.text!
            writeThingInRealm(thing)
            thingTextField.text = String()
            shoppingHistoryListTableView.reloadData()
        }
    }
}

extension NewRegistrationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard things != nil else { return 0 }
        return things.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = things[indexPath.row].thingName
        return cell
    }
    
}

extension NewRegistrationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thing = things[indexPath.row]
        Alert.presentAdd(on: self, thingName: thing.thingName) { _ in
            self.realmManager.updateThingDeleteFlag(thing, isDelete: false)
        }
    }
    
}
