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

public class ChenzookLocationNavigator: NSObject {
    
    public static var bundle: Bundle { return Bundle(for: self) }
    
    public static let shared = ChenzookLocationNavigator()
    private override init(){}
    
    public func isNavigatorShortcutReachable(_ navigator: NavigatorShortcut) -> Bool {
        var urlComponents = URLComponents()
        urlComponents.scheme = navigator.urlScheme
        urlComponents.host = ""
        
        guard let urlScheme = urlComponents.url?.absoluteURL else {
            assertionFailure("Invalid url scheme: \(navigator.urlScheme)")
            return false
        }
        
        return UIApplication.shared.canOpenURL(urlScheme)
    }
    
    public func navigate(to placemark: Placemark, using navigatorShortcut: NavigatorShortcut) {
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
    
    public func navigatorActionSheet(place: Placemark) -> UIAlertController {
        let actionSheet = UIAlertController(title: "", message: "\n\n\n\n", preferredStyle: .actionSheet)
        let frame = CGRect(x: 8.0, y: 8.0, width: actionSheet.view.bounds.size.width - 8.0 * 4.5, height: 120.0)
        let horizontalFlowLayout = UICollectionViewFlowLayout()
        horizontalFlowLayout.scrollDirection = .horizontal
        horizontalFlowLayout.itemSize = CGSize(width: 76, height: 88)
        let view = UICollectionView(frame: frame, collectionViewLayout: horizontalFlowLayout)
        view.register(NavigatorShortcutCollectionViewCell.nib, forCellWithReuseIdentifier: NavigatorShortcutCollectionViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.contentInset = .init(top: 4, left: 0, bottom: 0, right: 0)
        actionSheet.view.addSubview(view)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.place = place
        return actionSheet
    }
    
    lazy var dataSource = Navigator.deafaults.filter() { isNavigatorShortcutReachable($0) }
    private var place: Placemark!
}

extension ChenzookLocationNavigator: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NavigatorShortcutCollectionViewCell", for: indexPath) as! NavigatorShortcutCollectionViewCell
        
        cell.navigatorShorcut = dataSource[indexPath.row]
        return cell
    }
}

extension ChenzookLocationNavigator: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NavigatorShortcutCollectionViewCell else {
            return assertionFailure("Unknown cell")
        }
        ChenzookLocationNavigator.shared.navigate(to: place, using: cell.navigatorShorcut)
    }
}
