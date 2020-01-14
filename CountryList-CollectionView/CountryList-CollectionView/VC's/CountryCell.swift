//
//  CountryCell.swift
//  CountryList-CollectionView
//
//  Created by Brendon Cecilio on 1/14/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit
import ImageKit

class CountryCell: UICollectionViewCell {
    
    @IBOutlet weak var countryFlagView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    public func configureCell(country: Country) {
        countryLabel.text = country.name
        capitalLabel.text = country.capital
        populationLabel.text = country.population.description
        
        let imageURL = "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png"
        
        countryFlagView.getImage(with: imageURL) { [weak self] (result) in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self?.countryFlagView.image = UIImage(systemName: "exclamationmark-triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.countryFlagView.image = image
                }
            }
        }
    }
}
