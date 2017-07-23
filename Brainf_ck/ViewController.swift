//
//  ViewController.swift
//  Brainf_ck
//
//  Created by Davide Russo on 22/07/17.
//  Copyright © 2017 Davide Russo. All rights reserved.
//

import UIKit

protocol IOStreamDelegate {
    
    func output(value: ValueType)
    func input() -> ValueType?
    
}

class ViewController: UIViewController, IOStreamDelegate {
    
    var brainfuckInterpreter : Brainf_ckInterpreter?

    @IBOutlet weak var programTextField: UITextField!
    @IBOutlet weak var outputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.brainfuckInterpreter = Brainf_ckInterpreter(iostreamDelegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func execute(_ sender: UIButton) {
        self.brainfuckInterpreter?.execute(program: self.programTextField.text)
    }

    @IBAction func clear(_ sender: UIButton) {
        self.outputTextField.text = ""
        self.brainfuckInterpreter = Brainf_ckInterpreter(iostreamDelegate: self)
    }
    
    func input() -> ValueType? {
        return nil
    }
    
    func output(value: ValueType) {
        self.outputTextField.text = self.outputTextField.text! + "\(value)"
    }
}

