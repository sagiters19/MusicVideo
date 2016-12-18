//
//  MyExtension.swift
//  MusicVideo
//
//  Created by Jack on 2016/12/15.
//  Copyright © 2016年 Jack. All rights reserved.
//

import UIKit

extension MusicVideoTVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.text!.lowercased()
        filterSearch(searchText: searchController.searchBar.text!);
    }
    
}
