//
//  APIManager.swift
//  MusicVideo
//
//  Created by Jack on 2016/12/8.
//  Copyright © 2016年 Jack. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString: String, completion:@escaping (_ result: String) -> Void) {
        
        let config = URLSessionConfiguration.ephemeral;
        
        let session = URLSession(configuration: config);
        
//        let session = URLSession.shared;
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(url:url as URL);
        
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in
            
            DispatchQueue.main.async {
                
                if error != nil {
                    completion((error?.localizedDescription)!)
                } else {
                    completion("NSURLSession successful");
                    print(data);
                }
                
            }
            
        }
        
        task.resume();
        
    }
    
}
