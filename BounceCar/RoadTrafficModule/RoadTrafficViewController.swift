//
//  ViewController.swift
//  HomeWork2
//
//  Created by Peter on 11.10.2024.
//

import UIKit

final class RoadTrafficViewController: UIViewController {
    // MARK: - Constant
    private enum Constant {
        enum LeftRightCar {
            static let topAnchor: Double = 200
            static let leadingEdgeOnScreen: Double = 700
            static let leadingEdgeOffScreen: Double = -300
        }
        
        enum RightLeftCar {
            static let topAnchor: Double = 390
            static let trailingEdgeOnScreen: Double = -700
            static let trailingEdgeOffScreen: Double = 300
        }
        
        enum CarView {
            static let width: Double = 281
            static let height: Double = 90
            static let duration: TimeInterval = 5
            static let delay: TimeInterval = 0.4
            static let options: UIView.AnimationOptions = [.repeat, .curveEaseIn]
        }
    }
    
    // MARK: - Variables
    private var leftRightLeadingAnchor: NSLayoutConstraint?
    private var rightLeftLeadingAnchor: NSLayoutConstraint?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpAnimations()
    }
    
    //MARK: - Setup
    private func setUp() {
        view.backgroundColor = .white
        setUpLeftRightCar()
        setUpRightLeftCar()
    }
    
    private func setUpAnimations() {
        animateMovmentLeftRightCar()
        animateMovmentRightLeftCar()
    }
    
    private func setUpLeftRightCar() {
        let car = Car(width: Constant.CarView.width, height: Constant.CarView.height, type: .leftRight)
        view.addSubview(car)
        car.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constant.LeftRightCar.topAnchor)
        leftRightLeadingAnchor = car.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                              constant: Constant.LeftRightCar.leadingEdgeOffScreen)
        leftRightLeadingAnchor?.isActive = true
    }
    
    private func setUpRightLeftCar() {
        let car = Car(width: Constant.CarView.width, height: Constant.CarView.height, type: .rightLeft)
        view.addSubview(car)
        car.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constant.RightLeftCar.topAnchor)
        rightLeftLeadingAnchor = car.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                               constant: Constant.RightLeftCar.trailingEdgeOffScreen)
        rightLeftLeadingAnchor?.isActive = true
    }
    
    // MARK: - Animation
    private func animateMovmentLeftRightCar() {
        UIView.animate(withDuration: Constant.CarView.duration, delay: Constant.CarView.delay, options:  Constant.CarView.options) {
            self.leftRightLeadingAnchor?.constant = Constant.LeftRightCar.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateMovmentRightLeftCar() {
        UIView.animate(withDuration: Constant.CarView.duration, delay: Constant.CarView.delay, options: Constant.CarView.options) {
            self.rightLeftLeadingAnchor?.constant = Constant.RightLeftCar.trailingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
    }
}


