//
//  PurchaseViewController.swift
//  PCybernetics
//
//  Created by Daniel Smith on 3/10/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import UIKit

class PurchaseViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    var items = [ClothingItem]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tableView.delegate = self
        tableView.dataSource = self
        
        ClothingItemController.getDummyData { items in
            print("got items")
            self.items = items
            self.tableView.reloadData()
        }
    }
}
