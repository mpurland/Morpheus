//
//  Section.swift
//  Morpheus
//
//  Created by Matthew Purland on 12/11/15.
//  Copyright © 2015 Matthew Purland. All rights reserved.
//

import Foundation

/// Sections
public protocol SectionType {
    typealias Row: RowType
    
    var rows: [Row] { get }
}
