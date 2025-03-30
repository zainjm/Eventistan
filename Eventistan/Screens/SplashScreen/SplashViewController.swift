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
        eventistanTitle.font = .headline1
    }
}


// MARK: - Binding
private extension SplashViewController {
    func bindViews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.onSplashAnimationCompleted()
        }
    }
}

// MARK: - Constants
private enum Constants {
    static let eventistanBackgroundLogo = "eventistan-logo"
    static let eventistanTitle = "Eventistan"
}
