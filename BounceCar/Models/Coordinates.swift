//
//  CarCoordinates.swift
//  HomeWork2
//
//  Created by Peter on 22.10.2024.
//

struct CarCoordinates {
    static var barHeights: [Double] =  [38, 50, 78, 55, 50, 55, 80, 80, 75, 70, 65, 58, 52, 25, 20, 20, 30]
    static var barIndent: [Double] = [30, 21, 3, 0, 0, 1, 2, 2, 5, 10, 16, 20, 30, 36, 35, 40, 45]
    static let barWidth: Double = 9
    static let barSpacing: Double = 8
    static let barCount = 17
}

struct WheelCoordinates {
    static let leftRightPositions = [4, 14]
    static let rightLeftPositions = [2, 12]
    static let wheelHeight: Double = 42
    static let wheelWidth: Double = 42
    static let wheelTopIndent: Double = 5
    static let wheelLeadingIndent: Double = -17
}
