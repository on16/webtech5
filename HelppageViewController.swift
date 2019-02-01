//
//  HelppageViewController.swift
//  ARSoundWave
//
//  Created by Benni  on 31.01.19.
//  Copyright © 2019 Benni . All rights reserved.
//

import UIKit

class HelppageViewController: UIPageViewController, UIPageViewControllerDataSource {

    lazy var controllerList:[UIViewController] = {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)

        let firstController = storyBoard.instantiateViewController(withIdentifier: "firstHelpView")
        let secondController = storyBoard.instantiateViewController(withIdentifier: "secondHelpView")
        let thirdController = storyBoard.instantiateViewController(withIdentifier: "thirdHelpView")

        return [firstController, secondController, thirdController]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self

        if let firstStep = controllerList.first {
            self.setViewControllers([firstStep], direction: .forward, animated: false, completion: nil)
        }

    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController)
                    -> UIViewController? {
        guard let currentControllerIndex = controllerList.index(of: viewController) else {return nil}

        let prevIndex = currentControllerIndex - 1
        guard prevIndex >= 0 else {return nil}
        guard controllerList.count > prevIndex else {return nil}

        return controllerList[prevIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController)
                    -> UIViewController? {
        guard let currentControllerIndex = controllerList.index(of: viewController) else {return nil}

        let nextIndex = currentControllerIndex + 1
        guard controllerList.count != nextIndex else {return nil}
        guard controllerList.count > nextIndex else {return nil}

        return controllerList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let identifier = controllerList.first {
            if let index = controllerList.index(of: identifier) {
                return index
            }
        }
        return 0
    }
}
