//
//  CRegistry.swift
//  Lunar
//
//  Created by Alex Lementuev on 5/18/15.
//  Copyright (c) 2015 Space Madness. All rights reserved.
//

import UIKit

final class CRegistry: NSObject
{
    typealias CommandLookup = Dictionary<String, CCommand>
    typealias CommandList = Array<CCommand> // FIXME: use linked list
    typealias ListCommandsFilter = (command: CCommand) -> Bool
    
    private static var m_commandsLookup: CommandLookup = CommandLookup() // FIXME: rename
    private static var m_commands: CommandList = CommandList() // FIXME: rename
    
    // MARK: Command registry
    
    static func Register(#command: CCommand) -> Bool // FIXME: rename
    {
        if command.Name.hasPrefix("@")
        {
            command.Flags |= CCommandFlags.Hidden
        }
        
        return AddCommand(command: command)
    }
    
    static func Unregister(#command: CCommand) -> Bool  // FIXME: rename
    {
        return RemoveCommand(command: command)
    }
    
    static func Unregister(#filter: ListCommandsFilter) -> Bool // FIXME: rename
    {
        var unregistered = false
    
        for var index: Int = m_commands.count - 1; index >= 0; --index
        {
            let cmd = m_commands[index]
            if filter(command: cmd)
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
        return ListCommands(filter: {
            return self.ShouldListCommand(command: $0, prefix: prefix, options: options);
        });
    }
    
    static func ListCommands(#filter: ListCommandsFilter) -> Array<CCommand>
    {
        var result = Array<CCommand>()
        
        for command: CCommand in m_commands
        {
            if filter(command: command)
            {
                result.append(command)
            }
        }
        
        return result
    }
    
    static func ShouldListCommand(#command: CCommand, prefix: String?, options: CommandListOptions = CommandListOptions.None) -> Bool
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
    
        // return prefix == nil || StringUtils.StartsWithIgnoreCase(command.Name, prefix); // FIXME!
        
        return true
    }

    private static func AddCommand(#command: CCommand) -> Bool // FIXME: rename
    {
        let name = command.Name
        for var index: Int = 0; index < m_commands.count; ++index
        {
            let otherCmd = m_commands[index]
            if command == otherCmd
            {
                return false // no duplicates
            }

            let otherName = otherCmd.Name
            if name < otherName
            {
                m_commands.insert(command, atIndex: index)
                m_commandsLookup[command.Name] = command
                return true
            }

            if name == otherName
            {
                m_commands[index] = command
                m_commandsLookup[command.Name] = command
                return true
            }
        }

        m_commands.append(command);
        m_commandsLookup[command.Name] = command;

        return true;
    }

    private static func RemoveCommand(#command: CCommand) -> Bool // FIXME: rename
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
