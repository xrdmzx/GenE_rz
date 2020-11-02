//
//  ProcessFeatures.swift
//  GenE_rz
//
//  Copyright © 2020 Group3b. All rights reserved.
//
import SwiftUI
import Foundation

class ProcessFeatures {
    
    static let genbankKeys = ProcessFeatures.parseGenbankFeatureKeys()
    
    static func parseGenbankFeatureKeys() -> [String] {
      let keysPath = Bundle.main.path(forResource: "genbankAppendixII_featureKeys", ofType: "txt")
      //let keysString = keysPath! as NSString
      let keysString = try! String(contentsOfFile: keysPath!, encoding: String.Encoding.utf8)
      var lines: [String] = []
      keysString.enumerateLines { line, _ in
          lines.append(line)
      }
      var keys: [String] = []
      for line in lines {
        if line.hasPrefix("Feature Key") {
          let key = (line as NSString).substring(from: "Feature Key".count)
          keys.append(key.trimmingCharacters(in: .whitespacesAndNewlines))
        }
      }
      return keys
    }
    
    func generateFeatures(featureList: [INSDFeature]) -> [Feature] {
        var features = [Feature]()
        var newFeature: Feature?
        for key in ProcessFeatures.genbankKeys {
            //for every feature in the featureList
            for item in featureList {
          if item.INSDFeature_key == key { // then it is a feature definition
            if let feature = newFeature {
              // Add the feature to the sequence if it exists
              features.append(feature)
            }
            // Start a new feature with key
            newFeature = Feature()
            // Parse location <- working on this...
            let locationString = item.INSDFeature_location
            // parse join type
            if (locationString as NSString).contains("join") {
              newFeature?.joinType = "join"
            } else if (locationString as NSString).contains("order") {
              newFeature?.joinType = "order"
            }
            // Split into individual location segments
            let segmentsToJoin = locationString.components(separatedBy: ",")
            for segment in segmentsToJoin {
              var newSegmentTuple: (start: Int, end: Int?, delimiter: String?, onCodingSequence: Bool) = (start: Int(), end: nil, delimiter: nil, onCodingSequence: true)
                if (segment as NSString).contains("..>") {
                newSegmentTuple.delimiter = "..>"
                } else if (segment as NSString).contains("<..") {
                newSegmentTuple.delimiter = "<.."
                } else if (segment as NSString).contains("..") {
                newSegmentTuple.delimiter = ".."
              }
                if (segment as NSString).contains("complement") {
                newSegmentTuple.onCodingSequence = false
              }
              let numberRegex = try? NSRegularExpression(pattern: "[0-9^]+")
              // Parse location starts/ends
                let numberMatches = numberRegex?.matches(in: segment, options: [], range: NSMakeRange(0, segment.count))
                if let matches = numberMatches{
                    for match in matches {
                        var location = (segment as NSString).substring(with: match.range)
                        if (location as NSString).contains("^") {
                            let carrotRange = (location as NSString).range(of: "^")
                            location = (location as NSString).substring(to: carrotRange.location)
                        // Indicate that this is in between...........
                      }
                      if Int(location) != nil
                      {
                        if (matches.firstIndex(of: match) == 0) {
                          newSegmentTuple.start = Int(location)!
                        } else {
                          newSegmentTuple.end = Int(location)
                        }
                      }
                    }
                }
                
              
              let x = newSegmentTuple
              newFeature?.positions.append(x)
              let newColor = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
                newFeature?.color = newColor
            }
            features.append(newFeature!)
          }
        }
    }
        return features
}
}
