//
//  SettingsViewController.swift
//  PCybernetics
//
//  Created by Daniel Smith on 3/10/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import UIKit
import Eureka

class SettingsViewController: FormViewController
{
    private let usStates = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    var curAddress = ShippoController.Address()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configForm()
        form.delegate = self
        title = "Account Settings"
    }
    
    private func configForm()
    {
        form +++ Section()
        <<< TextRow() { row in
            row.title = "Name"
            row.placeholder = "John Smith"
            row.onChange { row in
                self.curAddress.name = row.value ?? ""
            }
        }
        <<< EmailRow() { row in
            row.title = "Email"
            row.placeholder = "user@umd.edu"
            row.onChange { row in
                self.curAddress.email = row.value
            }
        }
        <<< PhoneRow() { row in
            row.title = "Phone"
            row.placeholder = "2123565432"
            row.onChange { row in
                self.curAddress.phone = row.value
            }
        }
        
        +++ Section("Address")
        <<< TextRow() { row in
            row.title = "Street Address"
            row.placeholder = "12345 Filmore Pl."
            row.onChange { row in
                self.curAddress.street1 = row.value ?? ""
            }
        }
        <<< TextRow() { row in
            row.title = "Street Address 2"
            row.placeholder = "Apt. 2"
            row.onChange { row in
                self.curAddress.street2 = row.value
            }
        }
        <<< TextRow() { row in
            row.title = "City"
            row.placeholder = "College Park"
            row.onChange { row in
                self.curAddress.city = row.value ?? ""
            }
        }
        <<< PhoneRow() { row in
            row.title = "Zip"
            row.placeholder = "48075"
            row.onChange { row in
                self.curAddress.zip = row.value ?? ""
            }
        }
        <<< PickerInlineRow<String>() { row in
            row.title = "State"
            row.options = usStates
            row.onChange { row in
                self.curAddress.state = row.value ?? ""
            }
        }
    }
}
