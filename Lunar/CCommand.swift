//
//  CCommand.swift
//  Lunar
//
//  Created by Alex Lementuev on 5/18/15.
//  Copyright (c) 2015 Space Madness. All rights reserved.
//

import UIKit

public class CCommand: NSObject
{
    public private(set) var Name: String // FIXME: rename
    public var Flags: CCommandFlags // FIXME: rename
    
    public init(name: String)
    {
        self.Name = name
        self.Flags = CCommandFlags.None
    }
}

extension CCommand: Equatable
{
}

public func ==(lhs: CCommand, rhs: CCommand) -> Bool
{
    return lhs.Name == rhs.Name
}

