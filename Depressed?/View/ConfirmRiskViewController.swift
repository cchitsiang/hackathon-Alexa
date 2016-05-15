//
//  ConfirmRisk.swift
//  Depressed?
//
//  Created by CS on 15/05/2016.
//  Copyright © 2016 Christian Lobach. All rights reserved.
//

import Foundation
import MBProgressHUD

class ConfirmRiskViewController: BaseViewController,  MBProgressHUDDelegate
{
    private var HUD : MBProgressHUD!
    
    @IBOutlet weak var gradientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        addGradient()
    }
    
    
    @IBAction func doneClicked(sender: AnyObject) {
        
        self.HUD = Helper.showHUD(self.HUD,parentView: self.view, delegate: self, message: "")
        
        let waitTime = Int64(2 * Double(NSEC_PER_SEC))
        
        let popTime = dispatch_time(DISPATCH_TIME_NOW, waitTime)
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            self.HUD.hide(true)
            
            // ...Run something once we're done with the background task...
            
            self.performSegueWithIdentifier("PerformanceSegue", sender: self)
        };
        
        
        
        
        
        
    }
    func addGradient(){
        //.viewThatHoldsGradient.frame.size //703DC8
        let purple = hexStringToUIColor("C36ACD")
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.gradientView.frame.size;
        gradient.colors = [purple.CGColor, purple.colorWithAlphaComponent(0).CGColor] //Or any colors
        self.gradientView.layer.addSublayer(gradient)
        
    }
}