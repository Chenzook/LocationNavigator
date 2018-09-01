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

public protocol NavigatorShortcut {
    var name: String { get }
    var iconImage: UIImage { get }
    
    var urlScheme: String { get }
    func universalLink(destination: Placemark) -> URL
    func shouldOpenWithDedicateAPI(destination: Placemark) -> Bool
}

public extension NavigatorShortcut {
    func shouldOpenWithDedicateAPI(destination: Placemark) -> Bool { return false }
}
