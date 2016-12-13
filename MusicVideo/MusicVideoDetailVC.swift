//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Jack on 2016/12/13.
//  Copyright © 2016年 Jack. All rights reserved.
//

import UIKit

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


}
