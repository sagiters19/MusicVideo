//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Jack on 2016/12/13.
//  Copyright © 2016年 Jack. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import LocalAuthentication

class MusicVideoDetailVC: UIViewController {

    var videos: Videos!
    
    var securitySwitch: Bool = false;
    
    @IBOutlet var vName: UILabel!
    @IBOutlet var videoImage: UIImageView!
    @IBOutlet var vGenre: UILabel!
    @IBOutlet var vPrice: UILabel!
    @IBOutlet var vRight: UILabel!
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        title = videos.vArtist;
        vName.text = videos.vName;
        vPrice.text = videos.vPrice;
        vRight.text = videos.vRights;
        vGenre.text = videos.vGenre;
        
        if videos.vImageData != nil {
            videoImage.image = UIImage(data: videos.vImageData! as Data);
        } else {
            videoImage.image = UIImage(named: "imageNotAvaliable");
        }
        
    }
    
    @IBAction func playVideo(_ sender: UIBarButtonItem) {
        
        let url = NSURL(string: videos.vVideoUrl)
        
        let player = AVPlayer(url: url as! URL);
        
        let playerViewController = AVPlayerViewController();
        
        playerViewController.player = player;
        
        self.present(playerViewController, animated: true) { 
            playerViewController.player?.play();
        }
        
    }
    
    @IBAction func socialMedia(_ sender: UIBarButtonItem) {
        
        securitySwitch = UserDefaults.standard.bool(forKey: "SecSetting");
        
        switch securitySwitch {
        case true:
            touchIDChk();
        default:
            shareMedia();
        }
        
    }
    
    func touchIDChk() {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "continue", style: .cancel, handler: nil));
        
        let context = LAContext();
        var touchIDError: NSError?;
        let reasonString = "Touch-Id authentication is needed to share info on Social Media";
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &touchIDError) {
            
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) in
                
                if success {
                    DispatchQueue.main.async {
                        self.shareMedia();
                    }
                } else {
                    
                    alert.title = "Unsuccessful!";
                    
                    switch policyError! {
                    case LAError.appCancel:
                        alert.message = "Authentication was cancelled by application";
                    case LAError.authenticationFailed:
                        alert.message = "The user failed to provide valid credentials";
                    case LAError.passcodeNotSet:
                        alert.message = "Passcode is not set on the device";
                    case LAError.systemCancel:
                        alert.message = "Authentication was cancelled by the system";
                    case LAError.touchIDLockout:
                        alert.message = "Too many failed attempts";
                    case LAError.userCancel:
                        alert.message = "You cancelled the request";
                    case LAError.userFallback:
                        alert.message = "Password not accepted, must use Touch-ID";
                    default:
                        alert.message = "Unable to Authentication!";
                    }
                    
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil);
                    }
                }
                
            })
            
        } else {
            
            alert.title = "Error";
            
            switch touchIDError! {
            case LAError.touchIDNotEnrolled:
                alert.message = "Touch ID is not enrolled";
            case LAError.touchIDNotAvailable:
                alert.message = "Touch ID is not available on the device";
            case LAError.passcodeNotSet:
                alert.message = "Passcode has not been set";
            case LAError.invalidContext:
                alert.message = "The context is invalid";
            default:
                alert.message = "Local Authentication not available";
            }
            
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil);
            }
            
        }
        
    }
    
    func shareMedia() {
        
        let activity1 = "Have you had the opportunity to see this Music Video?";
        let activity2 = ("\(videos.vName) by \(videos.vArtist)");
        let activity3 = "Watch it and tell me what you think?";
        let activity4 = videos.vLinkToiTunes;
        let activity5 = "(Shared with the Music Video App - Step It UP!)"
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3, activity4, activity5], applicationActivities: nil);
        
        activityViewController.completionWithItemsHandler = {(activity, success, items, error) in
            
            if activity == UIActivityType.mail {
                print("email selected");
            }
            
        }
        
        self.present(activityViewController, animated: true, completion: nil);
        
    }

}
