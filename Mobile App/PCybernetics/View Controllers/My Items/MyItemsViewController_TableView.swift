//
//  MyItemsViewController_TableView.swift
//  PCybernetics
//
//  Created by Daniel Smith on 3/11/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import UIKit

extension MyItemsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ClothingItem.getMyItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ClothingItemTableViewCell
        {
            cell.setClothingItem(item: ClothingItem.getMyItems()[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
}
