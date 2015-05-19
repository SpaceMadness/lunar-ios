//
//  CRegistryTest.swift
//  Lunar
//
//  Created by Alex Lementuev on 5/18/15.
//  Copyright (c) 2015 Space Madness. All rights reserved.
//

import UIKit
import XCTest

class CRegistryTest: XCTestCase
{
    override func setUp()
    {
        super.setUp()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func TestListCommands()
    {
        CRegistry.Clear()
        
        let a11: CCommand = cmd_a11()
        let a12: CCommand = cmd_a12()
        let b11: CCommand = cmd_b11()
        let b12: CCommand = cmd_b12()
        
        CRegistery.Register(command: a11)
        CRegistery.Register(command: a12)
        CRegistery.Register(command: b11)
        CRegistery.Register(command: b12)
        
        var commands = CRegistery.ListCommands()
        AssertTypes(commands, typeof(cmd_a11), typeof(cmd_a12), typeof(cmd_b11), typeof(cmd_b12));
        
        commands = CRegistery.ListCommands("a")
        AssertTypes(commands, typeof(cmd_a11), typeof(cmd_a12))
        
        commands = CRegistery.ListCommands("a1")
        AssertTypes(commands, typeof(cmd_a11), typeof(cmd_a12))
        
        commands = CRegistery.ListCommands("a11")
        AssertTypes(commands, typeof(cmd_a11))
        
        commands = CRegistery.ListCommands("a13")
        AssertTypes(commands)
    }
}

class cmd_a11 : CCommand
{
    init()
    {
        super.init(name: "a11")
    }
}

class cmd_a12 : CCommand
{
    init()
    {
        super.init(name: "a12")
    }
}

class cmd_b11 : CCommand
{
    init()
    {
        super.init(name: "b11")
    }
}

class cmd_b12 : CCommand
{
    init()
    {
        super.init(name: "b12")
    }
}