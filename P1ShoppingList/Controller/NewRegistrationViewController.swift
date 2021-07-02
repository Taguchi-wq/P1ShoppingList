//
//  NewRegistrationViewController.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/03.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit

class NewRegistrationViewController: UIViewController {

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var addThingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddThingButton()
    }
    
    private func setupAddThingButton() {
        addThingButton.layer.cornerRadius = addThingButton.bounds.height / 2
    }

}
