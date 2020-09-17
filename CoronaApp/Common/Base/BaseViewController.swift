//
//  BaseViewController.swift
//  CoronaApp
//
//  Created by andrew on 2020/02/26.
//  Copyright © 2020 Yunjjang. All rights reserved.
//

import UIKit

typealias CallBackClosure = ((Any) -> ())

class BaseViewController: UIViewController {
    
    var preparedData: [String: Any]?
    var nextPrepareData: [String: Any]?
    var callbackDataClosure: CallBackClosure? = nil
    var nextCallbackDataClosure: CallBackClosure? = nil
    var rootController: BaseNavigationController? { return self.navigationController as? BaseNavigationController }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BaseViewController {
            if let next = nextPrepareData {
                destination.preparedData = next
                nextPrepareData = nil
            }
            
            if let callback = nextCallbackDataClosure {
                destination.callbackDataClosure = callback
                nextCallbackDataClosure = nil
            }
        }
        
        super.prepare(for: segue, sender: sender)
    }
    
    deinit {
        print("Deinit : \(self)")
    }
    
    fileprivate var timeStamp: UInt64 = 0
    var preventButtonClick: Bool {
        guard (DataUtil.currentTime - timeStamp) > 500 else { return false }
        timeStamp = DataUtil.currentTime
        return true
    }
    
    @IBAction func onTouchClose(_ sender: UIButton?) {
        if let n = navigationController {
            n.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
}
