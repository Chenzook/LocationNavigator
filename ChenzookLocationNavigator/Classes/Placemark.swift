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

public protocol Placemark {
    var latitude: Double { get }
    var longitude: Double { get }
    var name: String { get }
    var url: URL? { get }
    var phoneNumber: String? { get }
}
