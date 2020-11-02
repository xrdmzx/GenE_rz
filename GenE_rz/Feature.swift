//
//  Feature.swift
//  GenE_rz
//
//  Copyright © 2020 Group3b. All rights reserved.
//

import Foundation
import SwiftUI

class Feature {
  var label: String?
  var color: CGFloat?
  var key = String()
  var joinType: String?
  var positions: [(start: Int, end: Int?, delimiter: String?, onCodingSequence: Bool)] = []
}
