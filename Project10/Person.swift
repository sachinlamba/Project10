//
//  Person.swift
//  Project10
//
//  Created by Sachin Lamba on 27/06/16.
//  Copyright © 2016 LambaG. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
