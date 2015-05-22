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
    
    var Flags: CCommandFlags // FIXME: rename
    
    public var IsHidden: Bool // FIXME: rename
    {
        get { return HasFlag(CCommandFlags.Hidden) }
        set { SetFlag(CCommandFlags.Hidden, newValue) }
    }
    
    public var IsSystem: Bool // FIXME: rename
    {
        get { return HasFlag(CCommandFlags.System) }
        set { SetFlag(CCommandFlags.System, newValue) }
    }
    
    public var IsDebug: Bool // FIXME: rename
    {
        get { return HasFlag(CCommandFlags.Debug); }
        set { SetFlag(CCommandFlags.Debug, newValue); }
    }
    
    public var IsPlayModeOnly: Bool // FIXME: rename
    {
        get { return HasFlag(CCommandFlags.PlayModeOnly) }
        set { SetFlag(CCommandFlags.PlayModeOnly, newValue) }
    }
    
    internal var IsManualMode: Bool = false
    
    public init(name: String)
    {
        self.Name = name
        self.Flags = CCommandFlags.None
    }
    
    // MARK: helpers
    
    func HasFlag(flag: CCommandFlags) -> Bool
    {
        return (Flags & flag) != CCommandFlags.None;
    }
    
    func SetFlag(flag: CCommandFlags, _ value: Bool)
    {
        if (value)
        {
            Flags |= flag;
        }
        else
        {
            Flags &= ~flag;
        }
    }
}

extension CCommand: Equatable
{
}

public func ==(lhs: CCommand, rhs: CCommand) -> Bool
{
    return lhs.Name == rhs.Name
}

