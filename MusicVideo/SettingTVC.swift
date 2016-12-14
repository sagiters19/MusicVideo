//
//  SettingTVC.swift
//  MusicVideo
//
//  Created by Jack on 2016/12/14.
//  Copyright © 2016年 Jack. All rights reserved.
//

import UIKit
import MessageUI

class SettingTVC: UITableViewController, MFMailComposeViewControllerDelegate {

    
    @IBOutlet var aboutDisplay: UILabel!
    @IBOutlet var feedbackDisplay: UILabel!
    @IBOutlet var securityDisplay: UILabel!
    @IBOutlet var touchID: UISwitch!
    @IBOutlet var bestImageDisplay: UILabel!
    
    @IBOutlet var APICnt: UILabel!
    @IBOutlet var sliderCnt: UISlider!
    @IBOutlet var numberOfVideosDisplay: UILabel!
    @IBOutlet var dragTheSliderDisplay: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(preferredFontChange), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil);
        
        tableView.alwaysBounceVertical = false;
        
        title = "Settings";
        
        touchID.isOn = UserDefaults.standard.bool(forKey: "SecSetting");
        
        if (UserDefaults.standard.object(forKey: "APICNT") != nil) {
            let theValue = UserDefaults.standard.object(forKey: "APICNT") as! Int;
            APICnt.text = "\(theValue)";
            sliderCnt.value = Float(theValue);
        } else {
            sliderCnt.value = 10.0;
            APICnt.text = ("\(Int(sliderCnt.value))");
        }
        
    }
    
    @IBAction func touchIdSec(_ sender: UISwitch) {
        
        let defaults = UserDefaults.standard;
        if touchID.isOn {
            defaults.set(touchID.isOn, forKey: "SecSetting");
        } else {
            defaults.set(false, forKey: "SecSetting");
        }
        
    }
    
    @IBAction func valueChanged(_ sender: AnyObject) {
        
        let defaults = UserDefaults.standard;
        defaults.set(Int(sliderCnt.value), forKey: "APICNT");
        APICnt.text = ("\(Int(sliderCnt.value))");
        
    }
    
    func preferredFontChange() {
        
        aboutDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline);
        feedbackDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline);
        securityDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline);
        bestImageDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline);
        APICnt.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline);
        numberOfVideosDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline);
        dragTheSliderDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote);
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 1 {
            
            let mailComposeViewController = configureMail();
            
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil);
            } else {
                mailAlert();
            }
            
            tableView.deselectRow(at: indexPath, animated: true);
            
        }
        
    }
    
    func configureMail() -> MFMailComposeViewController {
        
        let mailComposeVC = MFMailComposeViewController();
        mailComposeVC.mailComposeDelegate = self;
        mailComposeVC.setToRecipients(["sagiters19@gmail.com"]);
        mailComposeVC.setSubject("Music Video App Feedback");
        mailComposeVC.setMessageBody("Hi Jack,\n\nI would like to share the following feedback...\n", isHTML: false);
        return mailComposeVC;
        
    }
    
    func mailAlert() {
        
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No e-Mail Account setup for Phone", preferredStyle: .alert);
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
        }
        
        alertController.addAction(okAction);
        
        self.present(alertController, animated: true, completion: nil);
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Mail cancelled");
        case MFMailComposeResult.saved.rawValue:
            print("Mail saved");
        case MFMailComposeResult.sent.rawValue:
            print("Mail sent");
        case MFMailComposeResult.failed.rawValue:
            print("Mail Failed");
        default:
            print("Unknown Issue");
        }
        self.dismiss(animated: true, completion: nil);
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil);
    }

}
