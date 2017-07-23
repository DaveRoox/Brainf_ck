//
//  Brainf_ckInterpreter.swift
//  Brainf*ck
//
//  Created by Davide Russo on 22/07/17.
//  Copyright © 2017 Davide Russo. All rights reserved.
//

import Foundation

public class Brainf_ckInterpreter {
    
    private var tape: Tape
    private var iostreamDelegate: IOStreamDelegate?
    
    init(iostreamDelegate: IOStreamDelegate? = nil) {
        self.tape = Tape()
        self.iostreamDelegate = iostreamDelegate
    }
    
    func execute(program: String?) {
        
        DispatchQueue.main.async {
            var charArray: [Character] = []
            if let text = program {
                for c in text.characters {
                    charArray.append(c)
                }
                print(charArray)
                self.interpret(program: charArray)
            }
        }
        
    }
    
    func interpret(program: [Character]) {
        
        var programIndex = 0
        var brackets = 0
        var command: Character
        
        print(program)
        
        while programIndex < program.count {
            
            command = program[programIndex]
            print(programIndex)
            
            switch command {
                
            case ">":
                self.tape.incrementIndex()
                
            case "<":
                self.tape.decrementIndex()
                
            case "+":
                self.tape.increment()
                
            case "-":
                self.tape.decrement()
                
            case ".":
                self.iostreamDelegate?.output(value: self.tape.printRaw())
                
            case "_":
                self.iostreamDelegate?.output(value: self.tape.printInt())
                
            case ",":
                self.tape.input(value: self.iostreamDelegate?.input())
                
            case "[":
                if self.tape.activeValue == 0 {
                    brackets = 1
                    programIndex += 1
                    while self.tape.isValid(programIndex) && programIndex < program.count {
                        if program[programIndex] == "]" {
                            brackets -= 1
                            if brackets == 0 {
                                break
                            }
                        }
                        else if program[programIndex] == "[" {
                            brackets += 1
                        }
                        programIndex += 1
                    }
                }
                
            case "]":
                if self.tape.activeValue != 0 {
                    brackets = 1
                    programIndex -= 1
                    while programIndex >= 0 {
                        if program[programIndex] == "[" {
                            brackets -= 1
                            if brackets == 0 {
                                break
                            }
                        }
                        else if program[programIndex] == "]" {
                            brackets += 1
                        }
                        programIndex -= 1
                    }
                }
                
            default:
                break
            }
            
            if !self.tape.isValid(programIndex) {
                break
            }
            
            programIndex += 1
            
        }
    }
    
}
