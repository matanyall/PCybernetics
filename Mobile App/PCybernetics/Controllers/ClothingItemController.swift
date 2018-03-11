//
//  ClothingItemController.swift
//  PCybernetics
//
//  Created by Daniel Smith on 3/11/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation

struct ClothingItemController
{
    public static func getMyItems() -> [ClothingItem]
    {
        return []
    }
    
    public static func getDummyData(completion: @escaping ([ClothingItem]) -> ())
    {
        var ret = [ClothingItem]()
        let imageUrls = ["https://sc01.alicdn.com/kf/UT81Dy6XaxbXXagOFbXg/180772800/UT81Dy6XaxbXXagOFbXg.jpg",
                         "https://images-na.ssl-images-amazon.com/images/I/71IV8ACBPiL._SL1500_.jpg",
                         "https://www.polyvore.com/cgi/img-thing?.out=jpg&size=l&tid=63966674"]
        let types = ["shirt", "pants", "shirt"]
        let sizes = ["L", "32x34", "M"]
        let genders = ["mens", "mens", "womens"]
        let colors = ["blue", "grey", "red"]
        for i in 0..<3
        {
            let temp = ClothingItem(type: ClothingItem.ClothingType(rawValue: types[i])!, colorStr: colors[i], size: sizes[i], style: "fancy", gender: genders[i])
            temp.imageUrl = URL(string: imageUrls[i])
            ret.append(temp)
        }
        completion(ret)
    }

    public static func getAllItems(completion: @escaping ([ClothingItem]) -> ())
    {
        let url = URL(string: "www.klothe.tk:8080/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let dict: [String: Any] = ["mode": "getall"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: dict)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else
            {
                return
            }
            var ret = [ClothingItem]()

            if let jsonSerialized = try? JSONSerialization.jsonObject(with: data),
                let json = jsonSerialized as? [Any]
            {
                for item in json
                {
                    if let item = item as? [String: Any],
                        let imageUrl = item["imageurl"] as? URL,
                        let type = item["type"] as? String,
                        let color = item["color"] as? String,
                        let gender = item["gender"] as? String
                    {
                        if let size = item["size"] as? [String: Any],
                            let width = size["width"] as? Int,
                            let height = size["height"] as? Int
                        {
                            var temp = ClothingItem(type: ClothingItem.ClothingType(rawValue: type)!, colorStr: color, size: "\(width)x\(height)", style: "fancy", gender: gender)
                            temp.imageUrl = imageUrl
                            temp.colorStr = color
                            ret.append(temp)
                        }
                        else if let size = item["size"] as? String
                        {
                            var temp = ClothingItem(type: ClothingItem.ClothingType(rawValue: type)!, colorStr: color, size: size, style: "fancy", gender: gender)
                            temp.imageUrl = imageUrl
                            temp.colorStr = color
                            ret.append(temp)
                        }
                    }
                }
            }
            completion(ret)
        }
        task.resume()
    }
}
