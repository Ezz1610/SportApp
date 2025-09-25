//
//  PageViewController.swift
//  SportApp
//
//  Created by mohamed ezz on 25/09/2025.
//

import UIKit

import UIKit

class PageViewController: UIPageViewController {
    var arrContainers = [UIViewController]()
    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        
        if let footballView = storyboard?.instantiateViewController(withIdentifier: "FootballView"),
           let bascktballView = storyboard?.instantiateViewController(withIdentifier: "BascktballView"),
           let tennisView = storyboard?.instantiateViewController(withIdentifier: "TennisView"),
            let creckitView = storyboard?.instantiateViewController(withIdentifier: "CreckitView"){
            arrContainers.append(footballView)
            arrContainers.append(bascktballView)
            arrContainers.append(tennisView)
            arrContainers.append(creckitView)
        }

        delegate = self
        dataSource = self

        if let firstVC = arrContainers.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

        addPageControl()
    }

    func addPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 75, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = arrContainers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(pageControl)
    }
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = arrContainers.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return arrContainers[currentIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = arrContainers.firstIndex(of: viewController), currentIndex < arrContainers.count - 1 else {
            return nil
        }
        return arrContainers[currentIndex + 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed,
              let visibleViewController = pageViewController.viewControllers?.first,
              let index = arrContainers.firstIndex(of: visibleViewController) else {
            return
        }
        pageControl.currentPage = index
    }
}
