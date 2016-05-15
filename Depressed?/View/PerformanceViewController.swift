//
//  PerformanceViewController.swift
//  Depressed?
//
//  Created by CS on 15/05/2016.
//  Copyright © 2016 Christian Lobach. All rights reserved.
//

import Foundation

class PerformanceViewController: BaseViewController
{
    
    @IBOutlet weak var gradientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        addGradient()
        //forDemo()
    }
    
    func forDemo() {
        let dateTime = NSDate(timeIntervalSinceNow: 3)
        let notification = UILocalNotification()
        notification.applicationIconBadgeNumber = 1
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.fireDate = dateTime
        notification.alertBody = "We will charge your account to to invest in RHB Focus Income Bond Fund..."
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
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