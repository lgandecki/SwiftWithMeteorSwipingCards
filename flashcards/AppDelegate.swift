//
//  AppDelegate.swift
//  SwiftTinderCards
//
//  Created by Lukasz Gandecki on 3/23/15.
//  Copyright (c) 2015 Lukasz Gandecki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navController: UINavigationController!
    var meteorClient =  initialiseMeteor("pre2", "wss://thebrain.pro/websocket");
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        addSubscriptions()
        setLoginController()
        setConnectionNotifications()
//        configureParse()
        // Override point for customization after application launch.
        return true
    }
    
    func addSubscriptions() {
        meteorClient.addSubscription("itemsToReLearnCount")
        meteorClient.addSubscription("itemsToRepeatCount")
        meteorClient.addSubscription("publicCourses")
        meteorClient.addSubscription("customItemsToReLearn")
        meteorClient.addSubscription("customItemsToRepeat")
        meteorClient.addSubscription("itemsToExtraRepeat")
    }
    
    func setLoginController() {
        var loginController:LoginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        loginController.meteor = self.meteorClient
        self.navController = UINavigationController(rootViewController:loginController)
        self.navController.navigationBarHidden = true
        
        //This needs to be modified to fix the screen size issue. (Currently a Bug)
//        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = self.navController
        self.window!.makeKeyAndVisible()

    }
    
    func setConnectionNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reportConnection", name: MeteorClientDidConnectNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reportDisconnection", name: MeteorClientDidDisconnectNotification, object: nil)
        
    }
    
    func reportConnection() {
        println("================> connected to server!")
    }
    
    func reportDisconnection() {
        println("================> disconnected from server!")
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        meteorClient.ddp.connectWebSocket()
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    

    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

