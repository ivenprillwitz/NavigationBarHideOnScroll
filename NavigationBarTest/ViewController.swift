//
//  ViewController.swift
//  NavigationBar
//
//  Created by Iven Prillwitz on 17.11.17.
//  Copyright © 2017 Iven Prillwitz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var lastContentOffset: CGFloat = 0
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView()
        view.backgroundColor = .white

        let topView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        navigationItem.titleView = topView

        let label = UILabel()
        label.text = "NavigationBar"
        label.translatesAutoresizingMaskIntoConstraints = false

        topView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true

        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        self.view = view
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Cell"
        return cell
    }
}

extension ViewController: UIScrollViewDelegate  {

    enum NavigationBarState {
        case hide
        case show
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastContentOffset < scrollView.contentOffset.y {
            animateNavigationBar(.hide, withDuration: 0.3)

        } else if lastContentOffset > scrollView.contentOffset.y {
            animateNavigationBar(.show, withDuration: 0.3)
        }
    }

    func animateNavigationBar(_ state: NavigationBarState, withDuration duration: Double = 0.3) {

        let statusBarHeight = UIApplication.shared.statusBarFrame.height

        if let bounds = self.navigationController?.navigationBar.bounds {
            var navigationBarHeight = bounds.height
            if navigationBarHeight != statusBarHeight {
                navigationBarHeight -= (navigationBarHeight - statusBarHeight)
            }

            let yValue: CGFloat = state == .hide ? 0 : navigationBarHeight
            let inset: CGFloat = state == .hide ? -navigationBarHeight : 0
            let alpha: CGFloat = state == .hide ? 0 : 1

            UIView.animate(withDuration: duration, animations: {
                self.navigationController?.navigationBar.frame = CGRect(x: 0,
                                                                        y: yValue,
                                                                        width: bounds.width,
                                                                        height: bounds.height)

                self.navigationItem.titleView?.alpha = alpha

                let scrollView = self.tableView
                scrollView.contentInset = UIEdgeInsets(top: inset, left: 0, bottom: 0, right: 0)
                scrollView.scrollIndicatorInsets = UIEdgeInsets(top:  inset, left: 0, bottom: 0, right: 0)
                self.view.layoutSubviews()
            })
        }
    }
}

