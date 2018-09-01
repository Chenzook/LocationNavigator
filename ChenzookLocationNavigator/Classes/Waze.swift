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

public struct Waze: NavigatorShortcut {
    public let name = "Waze"
    public var iconImage = UIImage.init(named: "Waze", in: Bundle.init(for: ChenzookLocationNavigator.self), compatibleWith: nil)!
    
    public var urlScheme = "waze"
    public func universalLink(destination: Placemark) -> URL {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "waze"
        urlComponents.host = ""
        urlComponents.path = ""
        
        let locationItem = URLQueryItem(name: "ll", value: "\(destination.latitude),\(destination.longitude)")
        let navigate = URLQueryItem(name: "navigate", value: "yes")
        
        urlComponents.queryItems = [locationItem, navigate]
        
        return urlComponents.url!.absoluteURL
    }
    
}
