//
//  ViewController.swift
//  MusicVideo
//
//  Created by Jack on 2016/12/8.
//  Copyright © 2016年 Jack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call API
        let api = APIManager();
        api.loadData(urlString: "https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    }

    func didLoadData(result: String) {
        
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .alert);
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // do something if you want
        }
        
        alert.addAction(okAction);
        self.present(alert, animated: true, completion: nil);
        
    }

}

