//
//  TravelLocationViewController.swift
//  Depressed?
//
//  Created by CS on 15/05/2016.
//  Copyright © 2016 Christian Lobach. All rights reserved.
//

import Foundation
import GoogleMaps
import ParkedTextField

class TravelLocationViewController: BaseViewController
{
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var txtDays: ParkedTextField!
    
    @IBAction func autocompleteClicked(sender: AnyObject) {
        let filter = GMSAutocompleteFilter()
        filter.type = .City
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.autocompleteFilter = filter
        autocompleteController.delegate = self
        self.presentViewController(autocompleteController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        addGradient()
        addDoneButtonOnKeyboard()
        
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.Default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneButtonAction"))
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
         self.txtDays.inputAccessoryView = doneToolbar
    }
    
    func doneButtonAction()
    {
        self.txtDays.resignFirstResponder()
    }
    
    
    func addGradient(){
        let purple = hexStringToUIColor("C36ACD")
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.gradientView.frame.size;
        gradient.colors = [purple.CGColor, purple.colorWithAlphaComponent(0).CGColor] //Or any colors
        self.gradientView.layer.addSublayer(gradient)
        
    }
}

extension TravelLocationViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(viewController: GMSAutocompleteViewController, didAutocompleteWithPlace place: GMSPlace) {
        
        self.lblLocation.text = place.formattedAddress
        
        
        print("Place name: ", place.name)
        print("Place address: ", place.formattedAddress)
        print("Place attributions: ", place.attributions)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        self.txtDays.becomeFirstResponder()
    }
    
    func viewController(viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: NSError) {
        // TODO: handle the error.
        print("Error: ", error.description)
    }
    
    // User canceled the operation.
    func wasCancelled(viewController: GMSAutocompleteViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(viewController: GMSAutocompleteViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(viewController: GMSAutocompleteViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
}