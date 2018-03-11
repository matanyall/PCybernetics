//
//  UserDefaultsController.swift
//  PCybernetics
//
//  Created by Daniel Smith on 3/10/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
struct UserDefaultsController
{
    private static let defaults = UserDefaults.standard
    
    public static var SawProcessSend: Bool
    {
        get { return defaults.bool(forKey: "SawProcessSend") }
        set { defaults.set(newValue, forKey: "SawProcessSend") }
    }
    
    public static var SawProcessRecieve: Bool
    {
        get { return defaults.bool(forKey: "SawProcessRecieve") }
        set { defaults.set(newValue, forKey: "SawProcessRecieve") }
    }
}
