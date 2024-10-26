//
//  Car.swift
//  HomeWork2
//
//  Created by Peter on 17.10.2024.
//

import UIKit

final class Car: UIView {
    // MARK: - Constant
    private enum Constant {
        enum Car {
            static let duration: TimeInterval = 0.4
            static let delay = 0.1
            static let values = [2.5, -2, 1.5, -1, 0]
        }
        
        enum Wheel {
            static let duration: TimeInterval = 1
            static let delay: TimeInterval = 0
            static let options: UIView.AnimationOptions = [.curveLinear, .repeat]
            static let rotationClockwise: CGFloat = .pi
            static let rotationAntiClockwise: CGFloat = -0.99 * .pi
        }
        
        enum Color {
            static let blue: UIColor = .blue
        }
        
        enum Shadow {
            static let cornerRadius: Double = 4
            static let opacity: Float = 0.4
            static let radius: Double = 4
            static let offset: CGSize = .zero
        }
    }
    
    // MARK: - Properties
    private let width: Double
    private let height: Double
    private let type: MoveType
    private var views: [UIView] = []
    private var wheels: [UIView] = []
    
    // MARK: - Lifecycle
    init(width: Double, height: Double, type: MoveType) {
        self.height = height
        self.width = width
        self.type = type
        super.init(frame: .zero)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setUp() {
        setUpCar()
        setUpViews()
        setUpWheels()
        animateCar()
        animateWheels()
    }
    
    private func setUpCar() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        if type == .rightLeft {
            Coordinates.Car.barIndent.reverse()
            Coordinates.Car.barHeights.reverse()
        }
    }
    
    private func setUpViews() {
        for i in 0..<Coordinates.Car.barCount {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = Constant.Color.blue
            view.layer.cornerRadius = Constant.Shadow.cornerRadius
            view.layer.shadowOpacity = Constant.Shadow.opacity
            view.layer.shadowRadius = Constant.Shadow.radius
            view.layer.shadowOffset = Constant.Shadow.offset
            view.layer.shadowColor = Constant.Color.blue.cgColor
            self.addSubview(view)
            view.pinLeft(to: self, Double(i) * (Coordinates.Car.barWidth + Coordinates.Car.barSpacing))
            view.pinTop(to: self, Coordinates.Car.barIndent[i])
            view.setHeight(Coordinates.Car.barHeights[i])
            view.setWidth(Coordinates.Car.barWidth)
            views.append(view)
        }
    }
    
    private func setUpWheels() {
        var wheelViews = [Int]()
        switch type {
        case .leftRight:
            wheelViews = Coordinates.Wheel.leftRightPositions
        case .rightLeft:
            wheelViews = Coordinates.Wheel.rightLeftPositions
        }
        
        for i in wheelViews {
            let wheel = CustomWheel(height: Coordinates.Wheel.wheelHeight, width: Coordinates.Wheel.wheelWidth)
            self.addSubview(wheel)
            wheel.pinTop(to: views[i].bottomAnchor, Coordinates.Wheel.wheelTopIndent)
            wheel.pinLeft(to: views[i], Coordinates.Wheel.wheelLeadingIndent)
            wheels.append(wheel)
        }
    }
    
    // MARK: - Animation
    private func animateCar() {
        for i in views.indices {
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                if i == self.views.count - 7 {
                    self.animateCar()
                }
            }
            
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
            animation.duration = Constant.Car.duration
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            animation.beginTime = CACurrentMediaTime() + Double(i) * Constant.Car.delay
            animation.values = Constant.Car.values
            switch type {
            case .leftRight:
                views[views.count - 1 - i].layer.add(animation, forKey: nil)
            case .rightLeft:
                views[i].layer.add(animation, forKey: nil)
            }
            CATransaction.commit()
        }
    }
    
    private func animateWheels() {
        for i in self.wheels.indices {
            UIView.animate(withDuration: Constant.Wheel.duration,
                           delay: Constant.Wheel.delay,
                           options: Constant.Wheel.options
            ) {
                switch self.type {
                case .leftRight:
                    self.wheels[i].transform = CGAffineTransform(rotationAngle: Constant.Wheel.rotationClockwise)
                case .rightLeft:
                    self.wheels[i].transform = CGAffineTransform(rotationAngle: Constant.Wheel.rotationAntiClockwise)
                }
            }
        }
    }
}
