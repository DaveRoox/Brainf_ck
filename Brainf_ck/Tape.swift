//
//  Tape.swift
//  Brainf*ck
//
//  Created by Davide Russo on 22/07/17.
//  Copyright © 2017 Davide Russo. All rights reserved.
//

import Foundation

public typealias ValueType = UInt8

public class Tape {
    
    var activeCell: Int
    var values: [ValueType]
    
    public var activeValue: ValueType {
        get {
            return self.values[activeCell]
        }
    }
    
    init() {
        self.activeCell = 0
        self.values = [0]
    }
    
    public func incrementIndex() {
        self.activeCell = self.activeCell + 1
        if self.activeCell >= self.values.count {
            self.values.append(0)
        }
    }
    
    public func decrementIndex() {
        if self.activeCell > 0 {
            self.activeCell = self.activeCell - 1
        }
    }
    
    public func increment() {
        self.values[activeCell] += 1
    }
    
    public func decrement() {
        self.values[activeCell] -= 1
    }
    
    public func printRaw() -> String {
        return "\(Character(UnicodeScalar(self.activeValue)))"
    }
    
    public func printInt() -> String {
        return "\(self.activeValue)"
    }
    
    public func input(value: ValueType?) {
        if let value = value {
            self.values[activeCell] = value
        }
    }
    
    public func isValid(_ index: Int) -> Bool {
        return 0 <= index
    }
}
