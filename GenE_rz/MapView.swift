//
//  MapView.swift
//  GenE_rz
//
//  Copyright © 2020 Group3b. All rights reserved.
//

import UIKit
import SwiftUI


@IBDesignable
class MapView: UIView
{
    @ObservedObject public var dataManager = DataManager.shared
    
    lazy var features = ProcessFeatures().generateFeatures(featureList: dataManager.featureList)

    lazy var sortedFeatures = features.sorted
{
  (s1: Feature, s2: Feature) in
  return s1.positions[0].start < s2.positions[0].start
}
  
  var selectedFeatureIndex: Int?
  {
    didSet(oldVal)
    {
      self.setNeedsDisplay()
    }
  }
  
    override func draw(_ rect: CGRect)
  {
    // set map inner radius
    var length = CGFloat()
    if self.bounds.size.height > self.bounds.size.width
    {
      length = self.bounds.width
    }
    else
    {
      length = self.bounds.height
    }
    let radius = length / 4
    // define center point
    let centerX = self.bounds.width / 2
    let centerY = self.bounds.height / 2
    let centerPoint = CGPoint(x: centerX, y: centerY)
    // create base circle
    let path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: 0, endAngle: 6.28, clockwise: true)
    path.close()
    path.lineWidth = 4
    path.stroke()
    // find fraction of circumference and radius for each feature
    var arcs: [(startRadians: CGFloat, endRadians: CGFloat, range: NSRange, ring: Int, color: UIColor, selected: Bool)] = []
    let sequenceLength = CGFloat(Int(truncating: (dataManager.dataSet?.INSDSeq.length)! as NSNumber ))
    for feature in self.sortedFeatures
    {
        for position in feature.positions
      {
        print(position)
        var newArc: (startRadians: CGFloat, endRadians: CGFloat, range: NSRange, ring: Int, color: UIColor, selected: Bool) = (startRadians: CGFloat(), endRadians: CGFloat(), range: NSRange(), ring: 1, color: UIColor.black, selected: false)
        let startIndex = position.start
        let endIndex = position.end ?? startIndex + 1;
        newArc.startRadians = (CGFloat(startIndex) / sequenceLength) * 6.28
        newArc.endRadians = (CGFloat(endIndex) / sequenceLength) * 6.28
        newArc.range = NSRange(location: startIndex, length: endIndex - startIndex)
        for arc in arcs
        {
          let intersection = NSIntersectionRange(newArc.range, arc.range)
          if intersection.length > 0 && newArc.ring == arc.ring
          {
            newArc.ring+=1
          }
        }
        if self.sortedFeatures.firstIndex(where: {$0 as AnyObject === feature as AnyObject}) == self.selectedFeatureIndex
        {
          newArc.selected = true
        }
        // add color
        newArc.color = UIColor(hue: feature.color ?? 12.2, saturation: 1, brightness: 1, alpha: 1)
        let new = newArc
        arcs.append(new)
      }
    }
    // draw feature arcs
    for arc in arcs
    {
      let arcRadius = radius + 20 * CGFloat(arc.ring)
      let path = UIBezierPath(arcCenter: centerPoint, radius: arcRadius, startAngle: arc.startRadians, endAngle: arc.endRadians, clockwise: true)
      if arc.selected
      {
        path.addLine(to: centerPoint)
        path.close()
        arc.color.setFill()
        path.fill()
      }
      else
      {
        path.lineWidth = 10
        arc.color.setStroke()
        path.stroke()
      }
    }
  }

}
