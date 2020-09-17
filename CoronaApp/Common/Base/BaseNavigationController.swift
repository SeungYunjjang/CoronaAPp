//
//  BaseNavigationController.swift
//  CoronaApp
//
//  Created by andrew on 2020/02/26.
//  Copyright © 2020 Yunjjang. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func pushViewController(storyBoard s: String, viewController v: String, animated: Bool = true) {
        self.pushViewController(UIStoryboard.init(name: s, bundle: nil).instantiateViewController(withIdentifier: v), animated: animated)
    }
    
    override func pushViewController(_ viewController: UIViewController?, animated: Bool) {
        guard let c = viewController else {
            print("pushing viewController is nil.")
            return
        }
        
        super.pushViewController(c, animated: animated)
    }
    
    
    func popToRootViewController(with viewController: UIViewController, animated: Bool) {
        self.viewControllers.insert(viewController, at: 0)
        super.popToRootViewController(animated: animated)
    }
}
