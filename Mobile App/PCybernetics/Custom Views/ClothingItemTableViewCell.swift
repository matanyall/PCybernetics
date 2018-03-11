//
//  ClothingItemTableViewCell.swift
//  PCybernetics
//
//  Created by Daniel Smith on 3/11/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import UIKit

class ClothingItemTableViewCell: UITableViewCell
{
    private var clothingItem: ClothingItem!
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    
    override func draw(_ rect: CGRect)
    {
        super.draw(rect)
        if let url = clothingItem.imageUrl
        {
            downloadAndSetImage(url: url)
        }
        detailLabel.text = "\(clothingItem.colorStr) \(clothingItem.style) \(clothingItem.type.rawValue)"
        sizeLabel.text = clothingItem.size
    }
    
    func setClothingItem(item: ClothingItem)
    {
        clothingItem = item
    }
    
    private func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    private func downloadAndSetImage(url: URL)
    {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print("Download Finished")
            DispatchQueue.main.async() {
                self.thumbnail.image = UIImage(data: data)
            }
        }
    }
}

extension UIImage
{

}
