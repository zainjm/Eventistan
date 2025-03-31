//
//  SelectCityBuilder.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 31/03/2025.
//

import Foundation
class SelectCityBuilder {
    class func build(selectCityTapped: (() -> Void)?,
                     currentLocationTapped: (() -> Void)?)
        -> SelectCityViewController {
        let vc = SelectCityViewController.instantiateViewController(from: .main)
        let viewModel = SelectCityViewModel()
        viewModel.onSelectCityTapped = selectCityTapped
        viewModel.onCurrentLocationTapped = currentLocationTapped
        vc.viewModel = SelectCityViewModel()
        return vc
    }
}
