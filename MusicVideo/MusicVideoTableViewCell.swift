//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Jack on 2016/12/12.
//  Copyright © 2016年 Jack. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    var video: Videos? {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet var musicImage: UIImageView!
    @IBOutlet var rank: UILabel!
    @IBOutlet var musicTitle: UILabel!

    func updateCell() {
        
        musicTitle.text = video?.vName;
        rank.text = ("\(video!.vRank)");
//        musicImage.image = UIImage(named: "imageNotAvaliable");
        
        if video!.vImageData != nil {
            print("Get data from array...");
            musicImage.image = UIImage(data: video!.vImageData! as Data);
        } else {
            GetVideoImage(video: video!, imageView: musicImage);
            print("Get images in background thread");
        }
        
    }
    
    func GetVideoImage(video: Videos, imageView: UIImageView) {
        
        DispatchQueue.global(qos: .default).async{
            
            let data = NSData(contentsOf: NSURL(string: video.vImageUrl)! as URL);
            
            var image: UIImage?
            if data != nil {
                
                video.vImageData = data;
                image = UIImage(data: data! as Data);
                
            }
            
            DispatchQueue.main.async {
                imageView.image = image;
            }
            
        }
        
    }
    
}
