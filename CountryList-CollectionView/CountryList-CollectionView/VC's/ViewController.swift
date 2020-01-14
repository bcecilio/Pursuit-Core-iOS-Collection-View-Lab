//
//  ViewController.swift
//  CountryList-CollectionView
//
//  Created by Brendon Cecilio on 1/14/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var country = [Country](){
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var searchQuery = "united" {
        didSet {
            loadData(search: searchQuery)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        loadData(search: searchQuery)
        view.backgroundColor = .lightGray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = collectionView.indexPathsForSelectedItems!.first else {
            return
        }
        detailVC.countryDetail = country[indexPath.row]
    }
    
    func loadData(search: String) {
        CountryAPIClient.getCountries(for: search) { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let countryData):
                self.country = countryData
                dump(countryData)
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return country.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCell else {
            fatalError("could not downcast CountryCell")
        }
        let countryCell = country[indexPath.row]
        cell.configureCell(country: countryCell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 5 // space between items
        let maxWidth = UIScreen.main.bounds.size.width // device's width
        let numberOfitems: CGFloat = 2 // items
        let totalSpacing: CGFloat = numberOfitems * interItemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfitems
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 2, bottom: 8, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text else {
            print("missing search text")
            return
        }
        searchQuery = searchText
    }
}

