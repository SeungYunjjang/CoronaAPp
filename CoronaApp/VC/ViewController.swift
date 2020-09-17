//
//  ViewController.swift
//  CoronaApp
//
//  Created by andrew on 2020/02/24.
//  Copyright © 2020 Yunjjang. All rights reserved.
//

import UIKit

class ViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var sideContainerView: UIView!
    @IBOutlet var stackView: UIStackView!
    
    private var isSideOn: Bool = true
    private var originStackViewCGPoint: CGPoint = CGPoint(x: 0, y: 0)
    private var vcArray: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        initTabItem()
    }

    @IBAction func edgeGesture(_ sender: Any) {
        if isSideOn {
            self.stackView.isHidden = false
            sideMenuAnimate(v: sideContainerView, isHidden: false)
            originStackViewCGPoint = stackView.center
            isSideOn = false
        }
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        
        if !isSideOn {
            sideMenuAnimate(v: sideContainerView, isHidden: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.stackView.isHidden = true
            }
            isSideOn = true
        }
        
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: stackView)
        
        let translation = sender.translation(in: stackView)
        let changeX = stackView.center.x + translation.x
        
        sender.cancelsTouchesInView = false
        
        if abs(velocity.x) > abs(velocity.y) {
            
            if velocity.x < 0 {
                //left swipe
                stackView.center = CGPoint(x:changeX, y: stackView.center.y)
                sender.setTranslation(CGPoint.zero, in: stackView)
                
            } else if velocity.x > 0 {
                //right swipe
                if stackView.center.x < view.center.x {
                    stackView.center = CGPoint(x:changeX, y: stackView.center.y)
                    sender.setTranslation(CGPoint.zero, in: stackView)
                    
                } else {
                    stackView.center = CGPoint(x:view.center.x, y: stackView.center.y)
                    sender.setTranslation(CGPoint.zero, in: stackView)
                }
            }
            
            if sender.state == .ended {
                
                if stackView.center.x < 0 {
                    sideMenuAnimate(v: sideContainerView, isHidden: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.stackView.isHidden = true
                    }
                    isSideOn = true
                }
                
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    usingSpringWithDamping: 0.9,
                    initialSpringVelocity: 1,
                    options: .transitionFlipFromLeft,
                    animations: {
                        self.stackView.center = self.originStackViewCGPoint
                        self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    @IBAction func tabbarItemBtn(_ sender: UIButton) {
        containerViewAdd(vcArray[sender.tag])
    }
    
    private func initTabItem() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let virusVC = sb.instantiateViewController(withIdentifier: "VirusVC") as? VirusViewController,
            let clinicVC = sb.instantiateViewController(withIdentifier: "ClinicVC") as? ClinicViewController,
            let infoSettingVC = sb.instantiateViewController(withIdentifier: "InfoSettingVC") as? InfoSettingViewController
            else {
                return
        }
        
        vcArray.append(virusVC)
        vcArray.append(clinicVC)
        vcArray.append(infoSettingVC)
        containerViewAdd(vcArray[0])
    }
    
    private func sideMenuAnimate(v: UIView, isHidden: Bool) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 1,
            options: .transitionFlipFromLeft,
            animations: {
                self.sideContainerView.isHidden = isHidden
                self.stackView.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func containerViewAdd(_ vc: UIViewController) {
        
        for viewController in vcArray {
            viewController.willMove(toParent: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParent()
        }
        
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vc.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            vc.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            vc.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            vc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        vc.didMove(toParent: self)
    }
    
}//class

