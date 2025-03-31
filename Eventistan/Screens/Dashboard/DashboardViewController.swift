//
//  DashboardViewController.swift
//  PK
//
//  Created by Zain Ul Abe Din on 06/11/2024.
//

import UIKit

final class DashboardViewController: UITabBarController {
    // MARK: - Properties
    var viewModel: DashboardViewModelType!
    private let floatingButton: UIButton = {
            let button = UIButton(type: .custom)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "Sell", in: .main, with: nil), for: .normal)
            button.layer.cornerRadius = 30
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.2
            button.layer.shadowOffset = CGSize(width: 0, height: 5)
            button.layer.shadowRadius = 5
            return button
        }()
    // MARK: View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Setup
private extension DashboardViewController {
    func setupViews() {
        view.backgroundColor = .primary
        
        tabBar.backgroundColor = .primary
        tabBar.tintColor = .overlay
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let normalTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.bodyXLarge,
            .foregroundColor: UIColor.primary
        ]
        
        let selectedTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.bodyXLarge,
            .foregroundColor: UIColor.primary
        ]
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primary
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalTitleAttributes
        appearance.stackedLayoutAppearance.normal.iconColor = .primary
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedTitleAttributes
        appearance.stackedLayoutAppearance.selected.iconColor = .primary
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        delegate = self
        setupFloatingButton()
    }
    
    private func setupFloatingButton() {
        view.addSubview(floatingButton)
        
        // Add constraints to position the button
        NSLayoutConstraint.activate([
            floatingButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            floatingButton.centerYAnchor.constraint(equalTo: tabBar.topAnchor, constant: 0),
            floatingButton.widthAnchor.constraint(equalToConstant: 60),
            floatingButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
    
    @objc private func floatingButtonTapped() {
        self.viewModel.shouldSelectionViewController(at: 2)
    }
}

extension DashboardViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let viewControllers = viewControllers,
              let index = viewControllers.firstIndex(of: viewController)
        else { return true }
        return viewModel.shouldSelectionViewController(at: viewControllers.distance(from: .zero, to: index))
    }
}
