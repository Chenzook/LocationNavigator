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
import MapKit.MKMapItem

public struct AppleMaps: NavigatorShortcut {
    public let name = "Apple Maps"
    public var iconImage = UIImage.init(named: "AppleMaps", in: Bundle.init(for: ChenzookLocationNavigator.self), compatibleWith: nil)!
    
    public var urlScheme = "Maps"
    public func universalLink(destination: Placemark) -> URL {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "maps.apple.com"
        urlComponents.path = "/"
        
        let locationItem = URLQueryItem(name: "q", value: "\(destination.latitude),\(destination.longitude)")
        urlComponents.queryItems = [locationItem]
        return urlComponents.url!.absoluteURL
    }
    
    public func shouldOpenWithDedicateAPI(destination: Placemark) -> Bool {
        let latitudeDegrees = CLLocationDegrees(destination.latitude)
        let longitudeDegrees = CLLocationDegrees(destination.longitude)
        let coordinate2D = CLLocationCoordinate2D(latitude: latitudeDegrees, longitude: longitudeDegrees)
        let placemark = MKPlacemark(coordinate: coordinate2D, addressDictionary: nil)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.phoneNumber = destination.phoneNumber
        mapItem.url = destination.url
        mapItem.name = destination.name
        mapItem.openInMaps(launchOptions: nil)
        return true
    }
}
