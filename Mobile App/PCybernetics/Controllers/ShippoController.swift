//
//  ShippoController.swift
//  PCybernetics
//
//  Created by Daniel Smith on 3/11/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation

struct ShippoController
{
    private static let testToken = "shippo_test_b27e3e43724170659d0126016592334235d35163"
    
    private static func getShippingRates(fromAddress: Address, toAddress: Address)
    {
        let url = URL(string: "https://api.goshippo.com/shipments/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("ShippoToken \(testToken)", forHTTPHeaderField: "Authorization")
        let dict: [String : Any] = ["address_from": fromAddress.getDictionary(), "address_to": toAddress.getDictionary(), "parcels": [Parcel.defaultParcel.getDictionary()], "async": false]
    }
    
    struct Address
    {
        var name: String!
        var street1: String!
        var street2: String?
        var city: String!
        var state: String!
        var zip: String!
        var country: String!
        var phone: String?
        var email: String?
        
        func getDictionary() -> [String: Any]
        {
            var dict: [String: Any] = ["name": name, "street1": street1, "city": city, "state": state, "zip": zip, "country": country]
            if let str = street2 { dict["street2"] = str }
            if let str = phone { dict["phone"] = str }
            if let str = email { dict["email"] = str }
            return dict
        }
    }

    struct Parcel
    {
        var length: String!
        var width: String!
        var height: String!
        let distance_unit = "in"
        var weight: String!
        let mass_unit = "lb"
        
        func getDictionary() -> [String: Any]
        {
            return ["length": length, "width": width, "height": height, "distance_unit": distance_unit, "weight": weight, "mass_unit": mass_unit]
        }
        
        static var defaultParcel: Parcel
        {
            var parcel = Parcel()
            parcel.length = "5"
            parcel.width = "5"
            parcel.height = "5"
            parcel.weight = "2"
            return parcel
        }
    }
}
