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
    typealias ListCommandsFilter = (cmd: CCommand) -> Bool
    
    private static var m_commandsLookup: CommandLookup = CommandLookup() // FIXME: rename
    private static var m_commands: CommandList = CommandList() // FIXME: rename
    
    // MARK: Command registry
    
    static func Register(cmd: CCommand) -> Bool // FIXME: rename
    {
        if cmd.Name.hasPrefix("@")
        {
            cmd.Flags |= CCommandFlags.Hidden
        }
        
        return AddCommand(cmd)
    }
    
    static func Unregister(#command: CCommand) -> Bool  // FIXME: rename
    {
        return RemoveCommand(command)
    }
    
    static func Unregister(#filter: ListCommandsFilter) -> Bool
    {
        var unregistered = false
    
        for var index: Int = m_commands.count - 1; index >= 0; --index
        {
            let cmd = m_commands[index]
            if filter(cmd: cmd)
            {
                unregistered = Unregister(command: cmd) || unregistered
            }
        }
        
        return unregistered
    }
    
    static func Clear()
    {
        m_commands.removeAll(keepCapacity: false)
        m_commandsLookup.removeAll(keepCapacity: false)
    }
    
    static func ListCommands(prefix: String? = nil, options: CommandListOptions = CommandListOptions.None) -> Array<CCommand>
    {
        return ListCommands(Array<CCommand>(), prefix, options)
    }
    
    static func ListCommands(outList: Array<CCommand>, prefix: String? = nil, options: CommandListOptions = CommandListOptions.None) -> Array<CCommand>
    {
        return ListCommands(outList, delegate(CCommand cmd)
        {
            return ShouldListCommand(cmd, prefix, options);
        });
    }
    
    static func ListCommands(#filter: ListCommandsFilter) -> Array<CCommand>
    {
        return ListCommands(ReusableLists.NextAutoRecycleList<CCommand>(), filter);
    }
    
    static func ListCommands(intout # outList: Array<CCommand>, # filter: ListCommandsFilter) -> Array<CCommand>
    {
        for command: CCommand in m_commands
        {
            if filter(command)
            {
                outList.append(command)
            }
        }
        
        return outList
    }
    
    static func ShouldListCommand(command: CCommand, prefix: String, options: CommandListOptions = CommandListOptions.None) -> Bool
    {
        if command.IsDebug && (options & CommandListOptions.Debug) == 0
        {
            return false
        }
    
        if command.IsSystem && (options & CommandListOptions.System) == 0
        {
            return false
        }
    
        if command.IsHidden && (options & CommandListOptions.Hidden) == 0
        {
            return false
        }
    
        return prefix == nil || StringUtils.StartsWithIgnoreCase(command.Name, prefix);
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
