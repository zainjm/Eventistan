//
//  SplashViewController.swift
//  App
//
//  Created by Zain Ul Abe Din on 20/02/2025.
//

import UIKit

final class SplashViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var background: UIImageView!
    @IBOutlet private weak var animationContainer: UIView!
    
    // MARK: - Properties
    var viewModel: SplashViewModelType!
    
    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - View setup
private extension SplashViewController {
    func setupViews() {
    }
}


// MARK: - Binding
private extension SplashViewController {
    func bindViews() {
    }
}
