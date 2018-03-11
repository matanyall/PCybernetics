//
//  ProcessController.swift
//  PCybernetics
//
//  Created by Daniel Smith on 3/11/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation

struct ProcessController
{
    private static var fromAddress = ShippoController.Address()
    private static var toAddress = ShippoController.Address()
    
    private static func configAddresses()
    {
        fromAddress.name = "Dani Smith"  
        fromAddress.street1 = "25572 Filmore Pl"
        fromAddress.city = "Southfield"
        fromAddress.state = "Michigan"
        fromAddress.zip = "48075"
        fromAddress.country = "US"
        fromAddress.email = "dsmith1@umd.edu"
        fromAddress.phone = "2482299912"
        
        toAddress.name = "Natasha D. Zuniga"
        toAddress.street1 = "4983 Larry Street"
        toAddress.city = "Waukesha"
        toAddress.state = "Wisconsin"
        toAddress.zip = "53186"
        toAddress.country = "US"
        toAddress.email = "NatashaDZuniga@rhyta.com"
        toAddress.phone = "4149817621"
    }
    
    public static func runForPretend()
    {
        configAddresses()
        MailGunController.emailShippingLabel(labelUrl: URL(string: "https://shop.wanderlust-webdesign.com/wp-content/uploads/2013/10/794616818333-720x720.png")! )
    }
}
