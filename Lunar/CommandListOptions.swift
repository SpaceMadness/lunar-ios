//
//  CommandListOptions.swift
//  Lunar
//
//  Created by Alex Lementuev on 5/18/15.
//  Copyright (c) 2015 Space Madness. All rights reserved.
//

import UIKit

public struct CCommandFlags
{
    private let value: Int
    
    private init(_ value: Int)
    {
        self.value = value
    }
    
    static let None         = CCommandFlags(0)
    static let Debug        = CCommandFlags(1 << 0)
    static let Hidden       = CCommandFlags(1 << 2)
    static let System       = CCommandFlags(1 << 3)
    static let PlayModeOnly = CCommandFlags(1 << 4)
}

public func | (left: CCommandFlags, right: CCommandFlags) -> CCommandFlags
{
    return CCommandFlags(left.value | right.value)
}

public func & (left: CCommandFlags, right: CCommandFlags) -> CCommandFlags
{
    return CCommandFlags(left.value & right.value)
}

public func |= (inout left: CCommandFlags, right: CCommandFlags)
{
    left = left | right
}