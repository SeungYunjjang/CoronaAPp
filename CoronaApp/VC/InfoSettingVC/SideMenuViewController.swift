//
//  SideMenuViewController.swift
//  CoronaApp
//
//  Created by andrew on 2020/02/24.
//  Copyright © 2020 Yunjjang. All rights reserved.
//

import UIKit

class SideMenuViewController: BaseViewController {

    @IBOutlet weak var insfectView: UIView!
    @IBOutlet weak var exminationView: UIView!
    @IBOutlet weak var freeView: UIView!
    @IBOutlet weak var deathView: UIView!
    
    @IBOutlet weak var insfectedLabel: UILabel!
    @IBOutlet weak var insfectionLabel: UILabel!
    @IBOutlet weak var isolateLabel: UILabel!
    @IBOutlet weak var deadLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setRadiusView()
    }
    
    private func setRadiusView() {
        insfectView.layer.cornerRadius = insfectView.frame.height / 2
        exminationView.layer.cornerRadius = exminationView.frame.height / 2
        freeView.layer.cornerRadius = freeView.frame.height / 2
        deathView.layer.cornerRadius = deathView.frame.height / 2
    }
    
    private func getJsonData() {
        let decoder = JSONDecoder()
        
        guard let path = Bundle.main.path(forResource: "InsfectedStatus", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let insfectedStatus = try? decoder.decode(InsfectedStatus.self, from: data)
            else { return }
        
        DispatchQueue.main.async {
            self.setDisplay(with: insfectedStatus)
        }
    }
    
    private func setDisplay(with model: InsfectedStatus) {
        insfectedLabel.text = model.infected
        insfectionLabel.text = model.insfection
        isolateLabel.text = model.isolate
        deadLabel.text = model.dead
        updateDateLabel.text = "업데이트 날짜 : \(model.update_date)"
    }

}
