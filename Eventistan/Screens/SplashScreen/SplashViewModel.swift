//
//  SplashViewModel.swift
//  App
//
//  Created by Zain Ul Abe Din on 20/02/2025.
//


protocol SplashViewModelType {
    var startAnimationInLoopCallback: (() -> Void)? { get set }
    
    func onSplashAnimationCompleted()
}

enum SplashAction {
    case animationCompleted
}

typealias SplashActionHandler = (SplashAction) -> Void

final class SplashViewModel: SplashViewModelType {
    // MARK: - Properties
    private let actionHandler: SplashActionHandler?
    var startAnimationInLoopCallback: (() -> Void)?
    private var isPerformingMigration = false
    private var isAnimationCycleCompleted = false
    
    // MARK: - Initialzation
    init(
        actionHandler: SplashActionHandler?
    ) {
        self.actionHandler = actionHandler
    }
    
    // MARK: - Function
    func onSplashAnimationCompleted() {
        actionHandler?(.animationCompleted)
    }
}
