//
//  Alert.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/04.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit

struct Alert {
    
    private static func basicAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        return alert
    }
    
    private static func twoButtonAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alert = basicAlert(title: title, message: message, handler: handler)
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
        return alert
    }
    
    static func presentPleaseWrite(on viewController: UIViewController) {
        let alert = basicAlert(title: "無くなったモノを入力して下さい", message: "", handler: nil)
        DispatchQueue.main.async { viewController.present(alert, animated: true) }
    }
    
    static func presentDuplicate(on viewController: UIViewController) {
        let alert = basicAlert(title: "モノの名前が重複しています。\n書き直して下さい", message: "", handler: nil)
        DispatchQueue.main.async { viewController.present(alert, animated: true) }
    }

    static func presentDelete(on viewController: UIViewController, handler: ((UIAlertAction) -> Void)?) {
        let alert = twoButtonAlert(title: "本当に削除しますか", message: "", handler: handler)
        DispatchQueue.main.async { viewController.present(alert, animated: true) }
    }
    
}
