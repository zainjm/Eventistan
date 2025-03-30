//
//  SplashViewController.swift
//  App
//
//  Created by Zain Ul Abe Din on 20/02/2025.
//

import UIKit

final class SplashViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var eventistanTitle: UILabel!
    @IBOutlet weak var eventraLogo: UIImageView!
    // MARK: - Properties
    var viewModel: SplashViewModelType!
    
    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViews()
    }
}

// MARK: - View setup
private extension SplashViewController {
    func setupViews() {
        view.backgroundColor = .blue500
        eventraLogo.image = UIImage(named: Constants.eventistanBackgroundLogo)
        eventistanTitle.text = Constants.eventistanTitle
        eventistanTitle.textColor = .primaryWhite
        eventistanTitle.font = .headline5
        let testFont = UIFont(name: "DMSans-Bold", size: 16)
        print("Loaded DM Sans Bold:", testFont ?? "FAILED TO LOAD")
        print(UIFont.fontNames(forFamilyName: "DM Sans"))
        for family in UIFont.familyNames {
            print("Family: \(family)")
            for font in UIFont.fontNames(forFamilyName: family) {
                print("  \(font)")
            }
        }
        if let boldFont = UIFont(name: "DMSans-9ptRegular_Bold", size: 16) {
            print("Loaded DM Sans Bold: \(boldFont)")
        } else {
            print("Failed to load DM Sans Bold")
        }
    }
}


// MARK: - Binding
private extension SplashViewController {
    func bindViews() {
    }
}

// MARK: - Constants
private enum Constants {
    static let eventistanBackgroundLogo = "eventistan-logo"
    static let eventistanTitle = "Eventistan"
}
