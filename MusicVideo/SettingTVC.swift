//
//  SettingTVC.swift
//  MusicVideo
//
//  Created by Jack on 2016/12/14.
//  Copyright © 2016年 Jack. All rights reserved.
//

import UIKit

class SettingTVC: UITableViewController {

    
    @IBOutlet var aboutDisplay: UILabel!
    @IBOutlet var feedbackDisplay: UILabel!
    @IBOutlet var securityDisplay: UILabel!
    @IBOutlet var touchID: UISwitch!
    @IBOutlet var bestImageDisplay: UILabel!
    
    @IBOutlet var APICnt: UILabel!
    @IBOutlet var sliderCnt: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(preferredFontChange), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil);
        
        tableView.alwaysBounceVertical = false;
        
    }
    
    func preferredFontChange() {
        
        aboutDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline);
        feedbackDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline);
        securityDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline);
        bestImageDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline);
        APICnt.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline);
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil);
    }

}
