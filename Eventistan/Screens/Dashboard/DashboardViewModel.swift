//
//  DashboardViewModel.swift
//  App
//
//  Created by Zain Ul Abe Din on 11/11/2024.
//

import Foundation

protocol DashboardViewModelType {
    var selectViewControllerCallback: ((Int) -> Void)? { get set }
    @discardableResult
    func shouldSelectionViewController(at index: Int) -> Bool
}

enum DashboardAction {
}

typealias DashboardActionHandler = (DashboardAction) -> Void

final class DashboardViewModel: DashboardViewModelType {
    // MARK: - Properties
    private let actionHandler: DashboardActionHandler?
    var selectViewControllerCallback: ((Int) -> Void)?
    
    // MARK: - Constant
    enum Constant {
        static let postAdIndex: Int = 2
        static let maxIndex: Int = 4
        
        static let userDefaultPostAdModelKey = "cellViewModels"
        static let userDefaulCategoryKey = "selectedCategory"
        static let userDefaultAllCategoriesKey = "allCategores"

    }
    
    // MARK: - Initialization
    init(
        actionHandler: DashboardActionHandler?
    ) {
        self.actionHandler = actionHandler
    }
    
    // MARK: - Functions
    @discardableResult
    func shouldSelectionViewController(at index: Int) -> Bool {
        return false
    }

}

// MARK: - Utils
private extension DashboardViewModel {
    func shouldSelectIndex(_ index: Int) -> Bool {
        guard index == Constant.postAdIndex else {
            return true
        }
        return false
    }
}

