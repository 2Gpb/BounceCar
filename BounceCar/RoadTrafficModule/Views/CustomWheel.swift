//
//  CusyomWheel.swift
//  HomeWork2
//
//  Created by Peter on 17.10.2024.
//

import UIKit

final class CustomWheel: UIView {
    //MARK: - Constant
    private enum Constant {
        enum Wheel {
            static let color: UIColor = .blue
        }
        enum Disk {
            static let color: UIColor = .white
            static let cornerRadius: Double = 6
        }
    }
    
    // MARK: - Properties
    private let width: Double
    private let height: Double
    private let wheelDisk = UIView()
    
    // MARK: - Lifecycle
    init(height: Double, width: Double) {
        self.height = height
        self.width = width
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        setupWheel()
        setupWheelDisk()
    }
    
    private func setupWheel() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = Constant.Wheel.color
        self.layer.cornerRadius = height / 2
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupWheelDisk() {
        wheelDisk.translatesAutoresizingMaskIntoConstraints = false
        wheelDisk.backgroundColor = Constant.Disk.color
        wheelDisk.layer.cornerRadius = Constant.Disk.cornerRadius
        self.addSubview(wheelDisk)
        wheelDisk.setHeight(height / 2)
        wheelDisk.setWidth(width / 2)
        wheelDisk.pinCenter(to: self)
    }
}
