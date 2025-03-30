//
//  GettingStartedViewController.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 30/03/2025.
//

import Foundation
import UIKit

final class GettingStartedViewController: UIViewController {
    
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet weak var firstHeadline: UILabel!
    @IBOutlet weak var secondHeadline: UILabel!
    @IBOutlet weak var gettingStartedButton: PrimaryButton!
    
    // MARK: - IBActions
    
    @IBAction func buttonTapped(_ sender: Any) {
        viewModel.onTap()
    }
    
    // MARK: - Properties
    
    var viewModel: GettingStartedViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupWithViewModel()
        bindViews()
    }
}

extension GettingStartedViewController {
    func setupViews() {
        view.backgroundColor = .blue500
        firstHeadline.font = .headline4
        secondHeadline.font = .paragraph3
        secondHeadline.textColor = .primaryWhite
        firstHeadline.textColor = .primaryWhite
        gettingStartedButton.title = "Getting Started"
        gettingStartedButton.titleLabel?.textColor = .primaryWhite
    }
    
    func setupWithViewModel() {
        image.image = UIImage(named: viewModel.imageName)
        firstHeadline.text = viewModel.headline1
        secondHeadline.text = viewModel.headline2
    }
    
    func bindViews() {
        
    }
}
