//
//  LoginViewController.swift
//  swiftddp
//
//  Created by Michael Arthur on 12/08/14.
//  Copyright (c) 2014. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var connectionStatusLight: UIImageView!
    @IBOutlet weak var connectionStatusText: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var sayHiButton: UIButton!
    
    var meteor:MeteorClient!
    
    override func viewWillAppear(animated: Bool) {
        var observingOption = NSKeyValueObservingOptions.New
        meteor.addObserver(self, forKeyPath:"websocketReady", options: observingOption, context:nil)
        view.endEditing(true)
        username.addTarget(self, action: "textFieldDone", forControlEvents: .EditingDidEndOnExit)
        password.addTarget(self, action: "textFieldDone", forControlEvents: .EditingDidEndOnExit)
        
    }
    
    func textFieldDone(sender: AnyObject) {
//        sender.resignFirstResponder()
//        if (sender as NSObject == self.password && self.meteor.websocketReady) {
//            login()
//        }
    }
    
    func login() {
        if (!self.meteor.websocketReady) {
            var notConnectedAlert = UIAlertView(title: "Connection Error", message: "Can't find the server, try again", delegate: nil, cancelButtonTitle: "OK")
            notConnectedAlert.show()
        }
        
        
        meteor.logonWithEmail(self.username.text, password: self.password.text, responseCallback: {(response, error) -> Void in
            
            if((error) != nil) {
                self.handleFailedAuth(error)
                return
            }
            self.handleSuccessfulAuth()
        })
    }
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<()>) {
        
        if (keyPath == "websocketReady" && meteor.websocketReady) {
            connectionStatusText.text = "Connected to Server"
            var image:UIImage = UIImage(named: "green_light.png")!
            connectionStatusLight.image = image
            loginButton.setTitle("Login", forState: .Normal)
            loginButton.enabled = true

        } else {
            connectionStatusText.text = "Not Connected to Server"
            var image:UIImage = UIImage(named: "red_light.png")!
            connectionStatusLight.image = image
            loginButton.setTitle("Connecting to Server", forState: .Normal)
            loginButton.enabled = false

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    @IBAction func didTapLoginButton(sender: AnyObject) {
        login()
        
    }
    
    func handleSuccessfulAuth() {
        
        let controller = ViewController()
        controller.meteor = self.meteor
        controller.userId = self.meteor.userId
        
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
    func handleFailedAuth(error: NSError) {
        UIAlertView(title: "TheBrain", message:error.localizedDescription, delegate: nil, cancelButtonTitle: "Try Again").show()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

