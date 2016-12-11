//
//  ViewController.swift
//  MusicVideo
//
//  Created by Jack on 2016/12/8.
//  Copyright © 2016年 Jack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var videos = [Videos]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call API
        let api = APIManager();
        api.loadData(urlString: "https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    }

    func didLoadData(videos: [Videos]) {
        
        print(reachabilitySatus);
        
        self.videos = videos;
        
        for item in videos {
            print("name = \(item.vName)");
        }
        
        for (index, item) in videos.enumerated() {
            print("\(index) name = \(item.vName)");
        }
        
//        for i in 0..<videos.count {
//            let video = videos[i];
//            print("\(i) name = \(video.vName)");
//        }
        
    }
    
    

}

