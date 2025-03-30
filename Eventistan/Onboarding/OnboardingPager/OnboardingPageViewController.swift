//
//  OnboardingPageViewController.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 30/03/2025.
//

import Foundation
import UIKit

final class OnboardingPageViewController: UIPageViewController {
    
    //MARK: Properties
    var pages: [UIViewController] = []
    private var isAnimating = false
    private var activeViewController: UIViewController?
    
    //MARK: Closures
    var onPageIndexChanged: ((Int) -> Void)?
    var onScrollProgress: ((CGFloat) -> Void)?
    var currentIndex: Int = 0
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupScrollViewDelegate()
    }
}

//MARK: Setup
private extension OnboardingPageViewController {
    func setupViews() {
        dataSource = self
        delegate = self
        view.backgroundColor = .primary
    }
    
    func setupScrollViewDelegate() {
        for view in self.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
                break
            }
        }
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < pages.count - 1 else {
            return nil
        }
        return pages[currentIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let viewController = pageViewController.viewControllers?.first, let index = pages.firstIndex(of: viewController) {
            currentIndex = index
            onPageIndexChanged?(index)
            DispatchQueue.main.async { [weak self] in
                self?.onScrollProgress?(CGFloat(index))
            }
        }
    }
}

//MARK: Callback to Main View Controller
extension OnboardingPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isAnimating else { return }

        let offsetX = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let totalPages = pages.count - 1
        let progress = (offsetX - width) / width + CGFloat(currentIndex)
        let clampedProgress = min(max(progress, 0), CGFloat(totalPages))
        
        onScrollProgress?(clampedProgress)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isAnimating = false
        guard let visibleViewController = viewControllers?.first,
              let index = pages.firstIndex(of: visibleViewController) else { return }
        currentIndex = index
        onPageIndexChanged?(index)
    }
}


