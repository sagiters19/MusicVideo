//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Jack on 2016/12/12.
//  Copyright © 2016年 Jack. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(preferredFontChange), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil);
        
        reachabilityStatusChanged();
        
        
        
    }
    
    func preferredFontChange() {
        
        print("The prefered Font has changed");
        
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
        
        tableView.reloadData();
        
        //        for i in 0..<videos.count {
        //            let video = videos[i];
        //            print("\(i) name = \(video.vName)");
        //        }
        
    }
    
    func reachabilityStatusChanged() {
        
        switch reachabilitySatus {
        case NOACCESS:
//            view.backgroundColor = UIColor.red;
            
            DispatchQueue.main.async {
    
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .alert);
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                    print("Cancel");
                })
                
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                    print("delete");
                })
                
                let okAction = UIAlertAction(title: "ok", style: .default, handler: { (action) in
                    print("Ok");
                })
                
                alert.addAction(okAction);
                alert.addAction(cancelAction);
                alert.addAction(deleteAction);
                
                self.present(alert, animated: true, completion: nil);
                
            }
            
        default:
//            view.backgroundColor = UIColor.green;
            if videos.count > 0 {
                print("do not refresh API");
            } else {
                runAPI();
            }
            
            
        }
        
    }
    
    func runAPI() {
        
        // Call API
        let api = APIManager();
        api.loadData(urlString: "https://itunes.apple.com/us/rss/topmusicvideos/limit=200/json", completion: didLoadData)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil);
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil);
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count;
    }

    private struct storyboard {
        static let cellReuseIdentifier = "cell";
        static let segueIdentifier = "musicDetail";
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: storyboard.cellReuseIdentifier, for: indexPath) as! MusicVideoTableViewCell;

        cell.video = videos[indexPath.row];
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132.0;
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == storyboard.segueIdentifier {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let video = videos[indexPath.row];
                let dvc = segue.destination as! MusicVideoDetailVC;
                dvc.videos = video;
                
            }
            
        }
    }

}
