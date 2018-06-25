//
//  SettingsRepository.swift
//  iCarCare
//
//  Created by Franco Rivera Rivas on 6/18/18.
//  Copyright © 2018 Franco. All rights reserved.
//

import Foundation
import CoreLocation

class SettingsRepository{
    let settings = UserDefaults.standard
    var auth_token: String?{
        get{
            return settings.string(forKey: "auth_token")
        }
        set{
            settings.set(newValue, forKey: "auth_token")
        }
    }
}
