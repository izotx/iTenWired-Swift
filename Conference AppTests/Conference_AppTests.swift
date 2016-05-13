//
//  Conference_AppTests.swift
//  Conference AppTests
//
//  Created by B4TH Administrator on 4/1/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import XCTest
@testable import Conference_App

class Conference_AppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSaveNotification(){
        
        let notificationController = NotificationController()
        let data = NSDictionary()
        let date = NSDate()
        // Creates a notification
        var notification = Notification(message: "This is a notification", aditionalData: data, date: date)
        notificationController.addNotification(notification)
        
        notification = Notification(message: "This is another notification", aditionalData: data, date: date)
        notificationController.addNotification(notification)
        
        let notifications = notificationController.getAllNotifications()
        
        // Test Assert
        let notification0 = notifications[0]
        let notification1 = notifications[1]
        print(notifications[0].message)
        print(notifications[1].message)
        
        XCTAssert(notification0.message == "This is another notification" || notification1.message == "This is another notification" , "Notifications are not equal!")
        XCTAssert(notification1.message == "This is a notification" || notification0.message == "This is a notification", "Notifications are not equal!")
        
    }
}
