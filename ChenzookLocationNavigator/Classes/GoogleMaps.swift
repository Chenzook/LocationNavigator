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

public struct GoogleMaps: NavigatorShortcut {
    public let name = "Google Maps"
    public var iconImage = UIImage.init(named: "GoogleMaps", in: Bundle.init(for: ChenzookLocationNavigator.self), compatibleWith: nil)!
    
    public var urlScheme = "comgooglemaps-x-callback"
    public func universalLink(destination: Placemark) -> URL {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "comgooglemaps-x-callback"
        urlComponents.host = ""
        urlComponents.path = ""
        
        let locationItem = URLQueryItem(name: "daddr", value: "\(destination.latitude),\(destination.longitude)")
        
        let sourceApp = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let sourceAppItem = URLQueryItem(name: "x-source", value: sourceApp)
        
        let sourceAppUniversalLink = sourceApp + "://?resume=true"
        let successItem = URLQueryItem(name: "x-success", value: sourceAppUniversalLink)
        
        urlComponents.queryItems = [locationItem, successItem, sourceAppItem]
        
        return urlComponents.url!.absoluteURL
    }
    
}
