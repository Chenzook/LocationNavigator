//
//  ViewController.swift
//  ChenzookLocationNavigator
//
//  Created by MojtabaHs on 06/24/2018.
//  Copyright (c) 2018 MojtabaHs. All rights reserved.
//

import UIKit
import ChenzookLocationNavigator
import MapKit.MKMapItem

class ViewController: UIViewController {

    var dataSource: [NavigatorShortcut] = [
        Navigator.waze,
        Navigator.googleMaps,
        Navigator.mapsWithMe,
        Navigator.appleMaps
    ]
    
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var latidute: Double {
        guard let number = Double(self.latitudeTextField.text!) else {
            fatalError("Invalid latitude input")
        }
        return number
    }
    
    private var longitude: Double {
        guard let number = Double(self.longitudeTextField.text!) else {
            fatalError("Invalid longitude input")
        }
        return number
    }
    
    private var place: Place {
        return Place(
            latitude: latidute,
            longitude: longitude,
            name: "Peeyade",
            url: URL(string: "https://peeyade.com"),
            phoneNumber: "+98 21 8888 77 66"
        )
    }
    
    @IBAction func makeDirection(_ sender: UIButton) {
        
        let actionSheet = ChenzookLocationNavigator.shared.navigatorActionSheet(place: place)
        present(actionSheet, animated: true, completion: nil)

    }

    override func viewDidLoad() {
        collectionView.register(NavigatorShortcutCollectionViewCell.nib, forCellWithReuseIdentifier: NavigatorShortcutCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDelegate {}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NavigatorShortcutCollectionViewCell", for: indexPath) as! NavigatorShortcutCollectionViewCell
        
        cell.navigatorShorcut = dataSource[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NavigatorShortcutCollectionViewCell else {
            return assertionFailure("Unknown cell")
        }
        
        ChenzookLocationNavigator.shared.navigate(to: place, using: cell.navigatorShorcut)
    }
}

struct Place: Placemark {
    var latitude: Double
    var longitude: Double
    var name: String
    var url: URL?
    var phoneNumber: String?
}
