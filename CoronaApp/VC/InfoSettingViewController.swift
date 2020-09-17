//
//  ThirdViewController.swift
//  SideMenu
//
//  Created by 승윤 on 06/04/2019.
//  Copyright © 2019 김승윤. All rights reserved.
//

import UIKit
import GoogleMobileAds

class InfoSettingViewController: BaseViewController {
    
    @IBOutlet weak var gadBannerView: GADBannerView!
    
    public struct InAppProducts {
        public static let product = "(인앱 Product ID)"
        private static let productIdentifiers: Set<ProductIdentifier> = [InAppProducts.product]
        public static let store = IAPHelper(productIds: InAppProducts.productIdentifiers)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAdmob()
//        InAppProducts.store.restorePurchases()
    }//viewDIdLoad
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gadBannerView.load(GADRequest())
    }
    
    @IBAction func IAPBtn(_ sender: UIButton) {
//        InAppProducts.store.buyProduct(<#T##product: SKProduct##SKProduct#>)
    }
    
    @IBAction func pushSettingBtn(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    private func setAdmob() {
        gadBannerView.delegate = self
        gadBannerView.rootViewController = self
        gadBannerView.adUnitID = "ca-app-pub-1642032393542105/1384393696"
    }
    
}//class

extension InfoSettingViewController: GADBannerViewDelegate {
    
}
