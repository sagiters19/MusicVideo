//
//  APIManager.swift
//  MusicVideo
//
//  Created by Jack on 2016/12/8.
//  Copyright © 2016年 Jack. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString: String, completion:@escaping ([Videos]) -> Void) {
        
        let config = URLSessionConfiguration.ephemeral;
        
        let session = URLSession(configuration: config);
        
//        let session = URLSession.shared;
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(url:url as URL);
        
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in
            
            
                
                if error != nil {
                    
                    print((error?.localizedDescription)!);
//                    completion((error?.localizedDescription)!);
                    
                    
                } else {
                
                    print(data);
                    
                    do {
                        
                        if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSONDictionary, let feed = json["feed"] as? JSONDictionary, let entries = feed["entry"] as? JSONArray {
                            
                            
                                
                            var videos = [Videos]();
                            for entry in entries {
                                let entry = Videos(data: entry as! JSONDictionary)
                                videos.append(entry);
                            }
                                
                            let i = videos.count;
                            print("iTunesApiManager - total count --> \(i)")
                            print(" ");
                            
                            DispatchQueue.global(qos: .userInitiated).async{
                                
                                DispatchQueue.main.async {
                                    completion(videos);
                                }
                                
                            }
                            
                        }
                        
                    } catch {
                        print("error in NSJSONSerialization");
                    }
                    
                }
            
            
        }
        
        task.resume();
        
    }
    
}
