//
//  CommandListOptions.swift
//  Lunar
//
//  Created by Alex Lementuev on 5/18/15.
//  Copyright (c) 2015 Space Madness. All rights reserved.
//

import UIKit

struct CommandListOptions: RawOptionSetType, BooleanType
{
    private let value: Int
    
    init(nilLiteral: ()) { self.init(rawValue: 0) }
    
    init(rawValue value: Int) { self.value = value }
    
    var boolValue: Bool { return value != 0 }
    
    var rawValue: Int { return value }
    
    static var allZeros: CommandListOptions { return self(rawValue: 0) }
    
    static var None:         CommandListOptions { return self(rawValue: 0) }
    static var Debug:        CommandListOptions { return self(rawValue: 1 << 0) }
    static var Hidden:       CommandListOptions { return self(rawValue: 1 << 1) }
    static var System:       CommandListOptions { return self(rawValue: 1 << 2) }
}

func == (lhs: CommandListOptions, rhs: Int) -> Bool { return lhs.rawValue == rhs }
func != (lhs: CommandListOptions, rhs: Int) -> Bool { return lhs.rawValue != rhs }