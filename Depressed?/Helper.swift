//
//  Helper.swift
//  Depressed?
//
//  Created by CS on 15/05/2016.
//  Copyright © 2016 Christian Lobach. All rights reserved.
//

import Foundation
import MBProgressHUD

class Helper {
    class func showHUD(HUD : MBProgressHUD?, parentView : UIView, delegate : MBProgressHUDDelegate, message: String) -> MBProgressHUD{
        // Clear & remove any previous HUD
        for view in parentView.subviews {
            if let previousHUD = view as? MBProgressHUD {
                previousHUD.removeFromSuperview()
                break
            }
        }
        
        // Init HUD
        let HUD = MBProgressHUD.init(view: parentView)
        
        // Add HUD into view
        parentView.addSubview(HUD)
        
        // Show HUD
        HUD.show(true)
        
        if (!message.isEmpty){
            // Init HUD
            HUD.mode = MBProgressHUDMode.CustomView
            HUD.delegate = delegate
            HUD.labelText = message
            
            // Hide message after 1 sec
            HUD.hide(true, afterDelay: 1.5)
        }
        
        return HUD
    }
    
    class func showHUDWithProgress(HUD : MBProgressHUD?, parentView : UIView, delegate : MBProgressHUDDelegate, message: String) -> MBProgressHUD{
        // Clear & remove any previous HUD
        for view in parentView.subviews {
            if let previousHUD = view as? MBProgressHUD {
                previousHUD.removeFromSuperview()
                break
            }
        }
        
        // Init HUD
        let HUD = MBProgressHUD.init(view: parentView)
        
        // Add HUD into view
        parentView.addSubview(HUD)
        
        // Show HUD
        HUD.show(true)
        
        HUD.delegate = delegate
        HUD.labelText = message
        
        return HUD
    }

}