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

import UIKit

public class NavigatorShortcutCollectionViewCell: UICollectionViewCell {
    
    public static var identifier: String { return String(describing: self) }
    public static var nib: UINib { return UINib(nibName: identifier, bundle: ChenzookLocationNavigator.bundle) }

    public var navigatorShorcut: NavigatorShortcut! {
        didSet {
            mapData()
        }
    }
    
    @IBOutlet private weak var iconMaskImageView: UIImageView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    private func mapData() {
        iconImageView.image = navigatorShorcut.iconImage
        nameLabel.text = navigatorShorcut.name
    }
    
}

@IBDesignable
class UIImageViewWithMask: UIImageView {
    var maskImageView = UIImageView()
    
    @IBInspectable
    var maskImage: UIImage? {
        didSet {
            maskImageView.image = maskImage
            updateView()
        }
    }
    
    // This updates mask size when changing device orientation (portrait/landscape)
    override func layoutSubviews() {
        super.layoutSubviews()
        updateView()
    }
    
    func updateView() {
        if maskImageView.image != nil {
            maskImageView.frame = bounds
            mask = maskImageView
        }
    }
}
