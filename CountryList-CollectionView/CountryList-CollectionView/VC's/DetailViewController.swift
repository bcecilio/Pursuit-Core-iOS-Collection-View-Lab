//
//  DetailViewController.swift
//  CountryList-CollectionView
//
//  Created by Brendon Cecilio on 1/14/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    var countryDetail: Country!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let country = countryDetail else {
            return
        }
        countryLabel.text = country.name
        capitalLabel.text = country.capital
        populationLabel.text = country.population.description
    }
}
