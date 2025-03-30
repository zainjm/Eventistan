//
//  OnboardingPageViewBuilder.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 30/03/2025.
//

import Foundation
struct InfoType {
    var firstImageName: String
    var secondImageName: String
    var firstPageTitle: String
    var firstPageSubtitle: String
    var secondPageTitle: String
    var secondPageSubtitle: String
}

class OnboardingPageViewBuilder {
    class func build() -> OnboardingPageViewController {
        let vc = OnboardingPageViewController.instantiateViewController(from: .main)

        let info = InfoType(
            firstImageName: "onboarding-lady-image-1",
            secondImageName: "onboarding-lady-image-2",
            firstPageTitle: "Simple Event Planning,\n Flawless Execution",
            firstPageSubtitle: "Your ultimate tool for seamless event\n planning, effortless coordination, and \nunforgettable experiences.",
            secondPageTitle: "Hassle-Free Setup, Smooth Delivery",
            secondPageSubtitle: "Easily plan your event with a streamlined process, ensuring smooth execution and memorable results."
        )

        let firstPage = GettingStartedBuilder.build(infoType: info, isFirstPage: true)
        let secondPage = GettingStartedBuilder.build(infoType: info, isFirstPage: false)

        let pages = [firstPage, secondPage]
        vc.pages = pages
        if let firstVC = pages.first {
            vc.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        return vc
    }
}

private enum Constants {
    static let firstImageName = ""
    static let secondImageName = ""
    static let firstPageTitle = ""
    static let firstPageSubtitle = ""
    static let secondPageTitle = ""
    static let secondPageSubTitle = ""
}
