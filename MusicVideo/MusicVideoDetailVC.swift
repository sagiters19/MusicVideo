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

class MusicVideoDetailVC: UIViewController {

    var videos: Videos!
    
    
    
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
        
        shareMedia();
        
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
