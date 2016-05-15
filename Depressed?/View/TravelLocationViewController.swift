//
//  TravelLocationViewController.swift
//  Depressed?
//
//  Created by CS on 15/05/2016.
//  Copyright © 2016 Christian Lobach. All rights reserved.
//

import Foundation
import GoogleMaps

class TravelLocationViewController: BaseViewController
{
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var lblLocation: UILabel!
    
    
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

extension TravelLocationViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(viewController: GMSAutocompleteViewController, didAutocompleteWithPlace place: GMSPlace) {
        
        self.lblLocation.text = place.name
        print("Place name: ", place.name)
        print("Place address: ", place.formattedAddress)
        print("Place attributions: ", place.attributions)
        self.dismissViewControllerAnimated(true, completion: nil)
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