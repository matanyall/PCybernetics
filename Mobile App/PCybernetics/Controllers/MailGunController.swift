//
//  mailGunController.swift
//  PCybernetics
//
//  Created by Daniel Smith on 3/11/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import SwiftMailgun

struct MailGunController
{
    public static func emailShippingLabel(labelUrl: URL)
    {
        let mailgun = MailgunAPI(apiKey: "key-adb504e32fb16978f2e797be7714453a", clientDomain: "sandbox617c45bf370541a9ac190bb702bfa289.mailgun.org")
        mailgun.sendEmail(to: "dsmith1@umd.edu", from: "Mailgun Sandbox <postmaster@sandbox617c45bf370541a9ac190bb702bfa289.mailgun.org>", subject: "Your Shipping Label", bodyHTML: "Your shipping label: \(labelUrl)") { mailgunResult in
            if mailgunResult.success
            {
                print("Email was sent")
            }
        }
    }
}
