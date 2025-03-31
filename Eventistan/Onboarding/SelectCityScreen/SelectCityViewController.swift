//
//  SelectCityViewController.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 31/03/2025.
//

import Foundation
import UIKit

final class SelectCityViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var termsAndServicesLabel: UILabel!
    @IBOutlet weak var useCurrentLocationButton: TertiaryButton!
    @IBOutlet weak var selectCityButton: PrimaryButton!
    @IBOutlet weak var discoverMemorableEventLabel: UILabel!
    @IBOutlet weak var helloLabel: UILabel!
    
    // MARK: - IBActions
    
    @IBAction func currentLocationButton(_ sender: Any) {
        viewModel.currentLocationTapped()
    }
    @IBAction func selectCityButton(_ sender: Any) {
        viewModel.selectCityTapped()
    }
    
    // MARK: - Properties
    var viewModel: SelectCityViewModelType!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupWithViewModel()
    }
}

extension SelectCityViewController {
    func setupViews() {
        self.setInteractivePopEnabled(true)
        termsAndServicesLabel.text = Constants.termsAndServicesText
        helloLabel.text = Constants.helloLabel
        selectCityButton.title = Constants.selectCityButtonText
        discoverMemorableEventLabel.text = Constants.discoverEventText
        useCurrentLocationButton.title = Constants.useCurrentLocationText
        
        helloLabel.font = .bodyJumbo
        discoverMemorableEventLabel.font = .bodyMedium
        discoverMemorableEventLabel.textColor = .secondaryLabel
        termsAndServicesLabel.font = .bodySmall
        termsAndServicesLabel.textColor = .secondaryLabel
        
    }
    func setupWithViewModel() {
        
    }
}

private enum Constants {
    static let discoverEventText = "Discover your next memorable event!\n Select your location below to begin."
    static let helloLabel = "Hello"
    static let selectCityButtonText = "Select a city"
    static let useCurrentLocationText = "Use My Current Location"
    static let termsAndServicesText = "I agree with Eventistan's terms of Use and Privacy Policy"
}
