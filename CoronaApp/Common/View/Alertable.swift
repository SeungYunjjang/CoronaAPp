//
//  Alertable.swift
//  CoronaApp
//
//  Created by andrew on 2020/02/27.
//  Copyright © 2020 Yunjjang. All rights reserved.
//

import UIKit

protocol Alertable {
    
}

extension Alertable where Self: UIViewController {
    
    func showAlert(title: String?,
                   message: String? = nil,
                   confirm: String,
                   cancel: String? = nil,
                   confirmAction: ((UIAlertAction) -> Void)? = nil,
                   cancelAction: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let action = cancelAction {
            alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: action))
        }
        
        alert.addAction(UIAlertAction(title: confirm, style: .default, handler: confirmAction))
        self.present(alert, animated: true, completion: nil)
    }
    
}
