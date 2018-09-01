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

public class ChenzookLocationNavigator {
    
    public static var bundle: Bundle { return Bundle(for: self) }
    
    public static func isNavigatorShortcutReachable(_ navigator: NavigatorShortcut) -> Bool {
        var urlComponents = URLComponents()
        urlComponents.scheme = navigator.urlScheme
        urlComponents.host = ""
        
        guard let urlScheme = urlComponents.url?.absoluteURL else {
            assertionFailure("Invalid url scheme: \(navigator.urlScheme)")
            return false
        }
        
        return UIApplication.shared.canOpenURL(urlScheme)
    }
    
    public static func navigate(to placemark: Placemark, using navigatorShortcut: NavigatorShortcut) {
        guard isNavigatorShortcutReachable(navigatorShortcut) else {
            return assertionFailure("\(navigatorShortcut.name) not installed")
        }
        
        guard !navigatorShortcut.shouldOpenWithDedicateAPI(destination: placemark) else { return }
        
        let universalURL = navigatorShortcut.universalLink(destination: placemark)
        guard UIApplication.shared.canOpenURL(universalURL) else {
            return assertionFailure("Invalid universal link: \(universalURL.absoluteString)")
        }
        UIApplication.shared.openURL(universalURL)
    }
}
