import UIKit
import ResearchKit
import ParkedTextField

class StartViewController: BaseViewController, ORKTaskViewControllerDelegate {
    
    private var aryItem : NSMutableArray!
    
    @IBOutlet weak var ageTextField: ParkedTextField!
    
    @IBOutlet weak var gradientView: UIView!

    @IBOutlet weak var tblOptions: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        addGradient()
        initOptions()
        initStyling()
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
    
    func initOptions() {
        self.aryItem = ["Travel", "Education", "Car", "Housing", "Marriage"]
    }
    
    // MARK: - TableView Lifecycle
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.aryItem.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
    UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath)
        
        let backView = UIView(frame: .zero)
        backView.backgroundColor = UIColor.clearColor();
        cell.backgroundView = backView;
        cell.backgroundColor = UIColor.clearColor();
        
        let value = self.aryItem.objectAtIndex(indexPath.row) as! String;
        
        let imgView = (cell.contentView.viewWithTag(1) as! UIImageView)
        imgView.image = UIImage(named: value.lowercaseString)
        
        let lblText = (cell.contentView.viewWithTag(2) as! UILabel)
        lblText.text = value;

        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You tapped cell number \(indexPath.row).")
        self.performSegueWithIdentifier("TravelLocationSegue", sender: self)
    }
    
    func initStyling() {
        tblOptions.backgroundColor = UIColor.clearColor();
        tblOptions.opaque = false;
        tblOptions.backgroundView = nil;
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
