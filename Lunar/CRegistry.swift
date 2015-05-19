//
//  CRegistry.swift
//  Lunar
//
//  Created by Alex Lementuev on 5/18/15.
//  Copyright (c) 2015 Space Madness. All rights reserved.
//

import UIKit

enum CommandListOptions: Int
{
    case None   = 0
    case Debug  = 1
    case Hidden = 2
    case System = 4
}

final class CRegistry: NSObject
{
    typealias CommandLookup = Dictionary<String, CCommand>
    typealias CommandList = Array<CCommand> // FIXME: use linked list
    
    private static var m_commandsLookup: CommandLookup = CommandLookup() // FIXME: rename
    private static var m_commands: CommandList = CommandList() // FIXME: rename
    
    // MARK: Command registry
    
    static func Register(cmd: CCommand) -> Bool
    {
        if cmd.Name.hasPrefix("@")
        {
            cmd.Flags |= CCommandFlags.Hidden
        }
        
        return AddCommand(cmd)
    }

    private static func AddCommand(cmd: CCommand) -> Bool
    {
        let name = cmd.Name
        for var index: Int = 0; index < m_commands.count; ++index
        {
            let otherCmd = m_commands[index]
            if cmd == otherCmd
            {
                return false // no duplicates
            }

            let otherName = otherCmd.Name
            if name < otherName
            {
                m_commands.insert(cmd, atIndex: index)
                m_commandsLookup[cmd.Name] = cmd
                return true
            }

            if name == otherName
            {
                m_commands[index] = cmd
                m_commandsLookup[cmd.Name] = cmd
                return true
            }
        }

        m_commands.append(cmd);
        m_commandsLookup[cmd.Name] = cmd;

        return true;
    }

    private static func RemoveCommand(command: CCommand) -> Bool
    {
        if let index = find(m_commands, command)
        {
            m_commands.removeAtIndex(index)
            m_commandsLookup.removeValueForKey(command.Name)
            
            return true
        }

        return false
    }

    static func FindCommand(name: String) -> CCommand?
    {
        if let cmd = m_commandsLookup[name]
        {
            return cmd
        }
        
        return nil;
    }
}
