//
//  Widget.swift
//  Widget Zone
//
//  Created by rey on 17/10/2021.
//

import Foundation

struct MyWidget: Identifiable, Codable {
    let name: String
    let description: String
    let color: String
    
    // alpha for color
    // var alpha: Float? = nil
    
    var id: String { name }
}
