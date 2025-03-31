//
//  SelectCityViewModel.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 31/03/2025.
//

import Foundation
protocol SelectCityViewModelType {
    func currentLocationTapped()
    func selectCityTapped()
}

final class SelectCityViewModel: SelectCityViewModelType {
    
    var onCurrentLocationTapped: (() -> Void)?
    var onSelectCityTapped: (() -> Void)?
    
    init() {}
    
    func currentLocationTapped() {
        onCurrentLocationTapped?()
    }
    
    func selectCityTapped() {
        onSelectCityTapped?()
    }
}
