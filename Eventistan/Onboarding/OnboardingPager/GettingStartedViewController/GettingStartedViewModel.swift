//
//  GettingStartedViewModel.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 30/03/2025.
//

import Foundation

protocol GettingStartedViewModelType {
    var imageName: String { get }
    var headline1: String { get }
    var headline2: String { get }
    func onTap()
}

final class GettingStartedViewModel: GettingStartedViewModelType {
    let imageName: String
    let headline1: String
    let headline2: String
    
    var tapCallback: (() -> Void)?
    
    init(_ info: InfoType, isFirstPage: Bool) {
        if isFirstPage {
            self.imageName = info.firstImageName
            self.headline1 = info.firstPageTitle
            self.headline2 = info.firstPageSubtitle
        } else {
            self.imageName = info.secondImageName
            self.headline1 = info.secondPageTitle
            self.headline2 = info.secondPageSubtitle
        }
    }
    
    func onTap() {
        tapCallback?()
    }
}
