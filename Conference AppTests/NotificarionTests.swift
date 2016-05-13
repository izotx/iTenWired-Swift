//
//  NotificarionTests.swift
//  Conference App
//
//  Created by Felipe on 5/10/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import XCTest

class NotificarionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(false, "OK")
        XCTAssertTrue(false)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSaveNotification(){
        
        let notificationController = NotificationController()
       // let data = NSDictionary()
        //let date = NSDate()
        
        // Creates a notification
        var notification = Notification(message: "This is a notification")
        notificationController.addNotification(notification)
        
        notification = Notification(message: "This is another notification")
        notificationController.addNotification(notification)
        
        let notifications = notificationController.getAllNotifications()
        
        XCTAssert(false, "Notifications are equal!")
    }

}
