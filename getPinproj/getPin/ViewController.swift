//
//  ViewController.swift
//  getPin
//
//  Created by Admin on 3/3/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func btnClk(_ sender: Any) {
        let s = presetPin.text;
        if s != "" {
            loadViewControllers("PinViewController");
        }
    }
    
    @IBOutlet weak var presetPin: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadViewControllers(_ named: String) {
        let storyboard = UIStoryboard.init(name: named, bundle: nil)
        let childView = storyboard.instantiateViewController(withIdentifier: named) as! PinViewController;
        childView.correctPin = presetPin.text!;
        childView.delegate = self
        self.navigationController?.pushViewController(childView, animated: true)
    }
}

