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
        musicImage.image = UIImage(named: "imageNotAvaliable");
        
    }
    
}
