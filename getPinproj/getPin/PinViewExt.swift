//
//  PinViewExt.swift
//  getPin
//
//  Created by Admin on 2/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
extension ViewController: PinViewDelegate {
    func childReturn(data: String) {
        print(data)
        self.navigationController?.popViewController(animated: true)
    }
    
    func resetPin() {
        print("reset PIN requests");
    }
    
    
}
