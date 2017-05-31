//
//  ViewController.swift
//  DTParallaxScrollViewController
//
//  Created by Tung Vo on 05/07/2016.
//  Copyright (c) 2016 Tung Vo. All rights reserved.
//

import UIKit
import DTParallaxScrollViewController
import MapKit

private let cellIdentifier = "Cell"
private let kHeaderHeight: CGFloat = 200

///
/// Class ViewController.
///
class ViewController: DTParallaxScrollViewController, UITableViewDataSource {
    fileprivate let _tableView: UITableView = UITableView(frame: CGRect.zero)
    fileprivate let _mapView = MKMapView()
    
    init() {
        super.init(scrollView: _tableView, headerHeight: kHeaderHeight)
        //_tableView.delegate = self
        _tableView.dataSource = self
        _tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.delegate = self
        self.parallaxScrollView.backgroundColor = UIColor.purple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _mapView.frame = CGRect(x: 0, y: -100, width: self.view.frame.width, height: kHeaderHeight + 200)
        // Test content inset
        //_tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 100, right: 0)
        
        self.updateBlock = {(yOffset: CGFloat, visible: Bool) -> Void in
            if yOffset < 0 {
                let scaleFactor = 1 + abs(yOffset/self.headerHeight)
                self._mapView.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
            }
            else {
                self._mapView.transform = CGAffineTransform.identity
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: UITableViewDataSource
extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = "Hello I am row number \(indexPath.row)"
        return cell
    }
}

//MARK: DTParallaxScrollViewDelegate
extension ViewController: DTParallaxScrollViewDelegate {
    func parallaxScrollViewViewForHeader(_ viewController: DTParallaxScrollView) -> UIView {
        return _mapView
    }
}

extension ViewController {
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

