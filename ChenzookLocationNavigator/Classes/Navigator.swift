//
//  Created by Seyed Mojtaba Hosseini Zeidabadi.
//  Copyright © 2018 Chenzook. All rights reserved.
//
//  Linkedin: https://linkedin.com/in/MojtabaHosseini
//  GitHub: https://github.com/MojtabaHs
//  Web: https://chenzook.com
//
//  License: MIT License
//

import Foundation

public enum Navigator {
    case custom(NavigatorShortcut)
    public static let appleMaps = AppleMaps()
    public static let googleMaps = GoogleMaps()
    public static let waze = Waze()
    public static let mapsWithMe = MapsWithMe()
}
