//
//  Alert.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/04.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit

struct Alert {
    
    private static func basicAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }
    
    static func presentPleaseWrite(on viewController: UIViewController) {
        let alert = basicAlert(title: "無くなったモノを入力して下さい", message: "")
        viewController.present(alert, animated: true)
    }
    
}
