//
//  ViewController.swift
//  SwiftTinderCards
//
//  Created by Lukasz Gandecki on 3/23/15.
//  Copyright (c) 2015 Lukasz Gandecki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var meteor:MeteorClient!
    var userId:NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var draggableViewBackground = DraggableViewBackground(frame: self.view.frame, meteor: self.meteor)
        self.view.addSubview(draggableViewBackground);
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//        self.meteor = 
    
}

