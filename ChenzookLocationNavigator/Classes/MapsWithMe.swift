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

public struct MapsWithMe: NavigatorShortcut {
    public let name = "maps.me"
    public var iconImage = UIImage(named: "MapsWithMe", in: Bundle(for: ChenzookLocationNavigator.self), compatibleWith: nil)!
    
    public var urlScheme = "mapswithme"
    public func universalLink(destination: Placemark) -> URL {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "mapswithme"
        urlComponents.host = "map"
        urlComponents.path = ""
        
        let versionItem = URLQueryItem(name: "v", value: "1")
        let locationItem = URLQueryItem(name: "ll", value: "\(destination.latitude),\(destination.longitude)")
        
        let sourceApp = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let sourceAppItem = URLQueryItem(name: "appname", value: sourceApp)

        let sourceAppUniversalLink = sourceApp + "://?resume=true"
        let successItem = URLQueryItem(name: "backurl", value: sourceAppUniversalLink)
        
        let nameItem = URLQueryItem(name: "n", value: destination.name)
        
        urlComponents.queryItems = [versionItem, locationItem, successItem, sourceAppItem, nameItem]
        
        return urlComponents.url!.absoluteURL
    }

}
