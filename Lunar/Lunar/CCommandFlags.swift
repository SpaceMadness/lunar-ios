//
//  CommandListOptions.swift
//  Lunar
//
//  Created by Alex Lementuev on 5/18/15.
//  Copyright (c) 2015 Space Madness. All rights reserved.
//

import UIKit

struct CCommandFlags: RawOptionSetType, BooleanType
{
    private let value: Int
    
    init(nilLiteral: ()) { self.init(rawValue: 0) }
    
    init(rawValue value: Int) { self.value = value }
    
    var boolValue: Bool { return value != 0 }
    
    var rawValue: Int { return value }
    
    static var allZeros: CCommandFlags { return self(rawValue: 0) }
    
    static var None:         CCommandFlags { return self(rawValue: 0) }
    static var Debug:        CCommandFlags { return self(rawValue: 1 << 0) }
    static var Hidden:       CCommandFlags { return self(rawValue: 1 << 1) }
    static var System:       CCommandFlags { return self(rawValue: 1 << 2) }
    static var PlayModeOnly: CCommandFlags { return self(rawValue: 1 << 3) }
}