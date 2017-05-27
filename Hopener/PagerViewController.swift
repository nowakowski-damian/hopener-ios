//
//  PagerViewController.swift
//  Hopener
//
//  Created by Damian Nowakowski on 07/05/2017.
//  Copyright © 2017 Damian Nowakowski. All rights reserved.
//

import UIKit

class PagerViewController: UIPageViewController {
    
    var currentIndex:Int = 0
    weak var pageDelegate:PageViewControllerDelegate?

    lazy var pageViewControllers: [UIViewController] = {
        let pageFence = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "PageItemViewController") as! PageItemViewController
        pageFence.labelName = "FENCE"
        pageFence.imageName = "fence"
        pageFence.gradientColors = [UIColor.rgb(38,166,154), UIColor.rgb(77,182,172), UIColor.rgb(128,203,196)]
        pageFence.cornersToRound = .bottomLeft
        
        let pageGarage = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "PageItemViewController") as! PageItemViewController
        pageGarage.labelName = "GARAGE"
        pageGarage.imageName = "garage"
        pageGarage.gradientColors = [UIColor.rgb(79,195,247), UIColor.rgb(3,169,244), UIColor.rgb(2,136,209)]
        pageGarage.cornersToRound = .bottomRight
        
        return [pageFence, pageGarage ]
    }()
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        // load first one
        if let firstViewController = pageViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


extension PagerViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let lastIndex = pageViewControllers.index(of: viewController) else {
            return nil
        }
        let index = lastIndex-1
        guard index>=0 else {
            return nil
        }
        return pageViewControllers[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let lastIndex = pageViewControllers.index(of: viewController) else {
            return nil
        }
        let index = lastIndex+1
        guard index<pageViewControllers.count else {
            return nil
        }
        return pageViewControllers[index]
    }

}

extension PagerViewController : UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.currentIndex = pageViewControllers.index(of: pendingViewControllers.first!)!
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else {
            return
        }
        pageDelegate?.onPageChanged(index: currentIndex)
    }
    
}




