//
//  ViewController.swift
//  pageViewController in same
//
//  Created by Digival on 14/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var customView: UIView!
    
    var pages = ["palani bro","guru bro","fazil bro","balaji bro"]
    var currentPage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
        customView.roundCorners([.topRight, .bottomRight], radius: 25)
    }
   
    func configurePageViewController() {
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: "page") as? pageViewController else {
            return
        }
        pageViewController.delegate = self
        pageViewController.dataSource = self
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let views:[String:Any] = ["pageView": pageViewController.view!]
        customView.addSubview(pageViewController.view)
        customView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|",options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        customView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|",options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
         pageViewController.view.bounds = customView.bounds
        guard let startingController = detailControllerAt(index:currentPage) else {
            return
        }

        pageViewController.setViewControllers([startingController], direction: .forward, animated: true)
//        NSLayoutConstraint.activate([
//            pageViewController.view.bottomAnchor.constraint(equalTo: customView.bottomAnchor,constant: 0),
//            pageViewController.view.topAnchor.constraint(equalTo: customView.topAnchor,constant: 0),
//            pageViewController.view.leadingAnchor.constraint(equalTo: customView.leadingAnchor,constant: 0),
//            pageViewController.view.trailingAnchor.constraint(equalTo: customView.trailingAnchor,constant: 0),
//        ])


    }
    func detailControllerAt(index: Int) -> DataViewController? {

        guard let dataController = storyboard?.instantiateViewController(withIdentifier: "data") as? DataViewController else {
            return nil}
        dataController.index = index
        dataController.labelText = pages[index]

        return dataController
    }
    
}
extension ViewController: UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentPage
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? DataViewController
        guard var currentindex = dataViewController?.index else { return nil }
        currentPage = currentindex
        currentindex -= 1
        if currentindex < 0 {
            currentindex = pages.count - 1
        }
      
        return detailControllerAt(index: currentindex)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as? DataViewController
        guard var currentindex = dataViewController?.index else { return nil }
        if currentindex >= pages.count {
            currentindex = pages.count + 1
        }
        currentindex += 1
        if currentindex >= pages.count {
            currentindex = 0
        }
       
        currentPage = currentindex
        return detailControllerAt(index: currentindex)
    }

    
}
extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
      let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
      let mask = CAShapeLayer()
      mask.path = path.cgPath
      self.layer.mask = mask
     }
    
}
