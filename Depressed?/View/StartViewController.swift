import UIKit
import ResearchKit

class StartViewController: BaseViewController, ORKTaskViewControllerDelegate {
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var gradientView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        addGradient()
        initStyling()
    }
    
    func initStyling() {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.whiteColor().CGColor
        border.frame = CGRect(x: 0, y: ageTextField.frame.size.height - width, width: ageTextField.frame.size.width, height: ageTextField.frame.size.height)
        
        border.borderWidth = width
        ageTextField.backgroundColor = UIColor.clearColor()
        ageTextField.layer.addSublayer(border)
        ageTextField.layer.masksToBounds = true
        ageTextField.borderStyle = UITextBorderStyle.None
        ageTextField.textColor = UIColor.whiteColor()
        //ageTextField.setBottomBorder("fff")
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func addGradient(){
    //.viewThatHoldsGradient.frame.size //703DC8
        let purple = hexStringToUIColor("C36ACD")
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.gradientView.frame.size;
        gradient.colors = [purple.CGColor, purple.colorWithAlphaComponent(0).CGColor] //Or any colors
        self.gradientView.layer.addSublayer(gradient)
        
    }
    
    @IBAction func startTest(sender: AnyObject) {

        let task = SelfTestTask()
        let taskController = ORKTaskViewController(task: task, taskRunUUID: nil)
        taskController.delegate = self
        taskController.modalPresentationStyle = .PageSheet

        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
        presentViewController(taskController, animated: true, completion: nil)
    }

    //MARK: - ORKTaskViewControllerDelegate

    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {

        if reason == .Completed, let results = taskViewController.result.results as? [ORKStepResult] {

            let evaluation = Evaluation(stepResults: results)

            if let evaluation = evaluation {

                let findingHelpInformation = FindingHelpInformation(locale: NSLocale.currentLocale())
                let viewModel = EvaluationViewModel(evaluation: evaluation, findingHelpInformation: findingHelpInformation)
                // swiftlint:disable:next force_cast
                let evaluationViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("EvaluationViewController") as! EvaluationViewController
                evaluationViewController.viewModel = viewModel

                navigationController?.pushViewController(evaluationViewController, animated: false)

            }
        }

        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        dismissViewControllerAnimated(true, completion: nil)
    }

}
