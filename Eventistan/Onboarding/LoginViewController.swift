//
//  LoginViewController.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 24/03/2025.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var image: UIImageView!
    
    var viewModel: LoginViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupWithViewModel()
    }
}


extension LoginViewController {
    func setup() {
        
    }
    
    func setupWithViewModel() {
        
    }
}
