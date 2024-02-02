//
//  PageViewController.swift
//  Apple Store
//
//  Created by Gamid Gapizov on 01.02.2024.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var welcomePages = [WelcomePageStructure]()
    private let applePic = UIImage(named: "apple")
    private let macPic = UIImage(named: "mac")
    private let mastercardPic = UIImage(named: "mastercard")
    private let cartPic = UIImage(named: "cart")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstPic = WelcomePageStructure(text: "Welcome to Apple Shop!", subText: "Get access to exclusive deals and products first!", image: applePic!)
        let secondPic = WelcomePageStructure(text: "Customize your Apple", subText: "Choose special gravings and colors for your favourite tech.", image: macPic!)
        let thirdPic = WelcomePageStructure(text: "Pay any way", subText: "Use most convenient way of payment. But better use Apple Pay of course", image: mastercardPic!)
        let fourthPic = WelcomePageStructure(text: "Order now", subText: "And get your tech tommorrow!", image: cartPic!, button: true, buttonText: "Start shopping")
        
        welcomePages.append(firstPic)
        welcomePages.append(secondPic)
        welcomePages.append(thirdPic)
        welcomePages.append(fourthPic)
    }
    
    lazy var arrayOfWelcomeVCs: [WelcomeViewController] = {
       var welcomeVC = [WelcomeViewController]()
        for page in welcomePages {
            welcomeVC.append(WelcomeViewController(source: page))
        }
        return welcomeVC
    }()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        self.view.backgroundColor = .white
        self.dataSource = self
        self.delegate = self
        
        setViewControllers([arrayOfWelcomeVCs[0]], direction: .forward, animated: true)
        
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        appearance.pageIndicatorTintColor = .systemGray
        appearance.currentPageIndicatorTintColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    internal func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? WelcomeViewController else { return nil }
        if let index = arrayOfWelcomeVCs.firstIndex(of: viewController) {
            if index > 0 {
                return arrayOfWelcomeVCs[index - 1]
            }
        }
        return nil
    }
    
    internal func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? WelcomeViewController else { return nil }
        if let index = arrayOfWelcomeVCs.firstIndex(of: viewController) {
            if index < welcomePages.count - 1 {
                return arrayOfWelcomeVCs[index + 1]
            }
        }
        return nil
    }
    
    internal func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return welcomePages.count
    }
    
    internal func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    

}
