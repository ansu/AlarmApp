//
//  AlarmAppTests.swift
//  AlarmAppTests
//
//  Created by Kuliza-282 on 28/08/17.
//  Copyright © 2017 Kuliza-282. All rights reserved.
//

import XCTest
@testable import AlarmApp
import UserNotifications


class LocalNotificatioSchedulerTestable : LocalNotificationSchedulable {
    
    var notificationsCancelled = false

    func cancelAllLocalNotifications() {
        notificationsCancelled = true
    }
    
    func getLocalNotificationPermissionStatus(completion:@escaping (Bool) -> Void) {
        completion(true)
    }
    
    func scheduleNotifcation(request:UNNotificationRequest, completion:@escaping (Bool) -> Void){
        completion(true)
    }

}


class AlarmAppTests: XCTestCase {
    
    var viewModel:AlarmViewModel?
    let application = LocalNotificatioSchedulerTestable()
    var localNotificationScheduler : LocalNotificationScheduler?
    let semaphore = DispatchSemaphore(value: 0)
    
    override func setUp() {
        super.setUp()
        self.localNotificationScheduler = LocalNotificationScheduler(application: self.application)
        viewModel = AlarmViewModelling(scheduler: self.localNotificationScheduler!)

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
   
    func testValidationFailed(){
        let validateStatus = viewModel!.validate(title: "", timeInterval: 0.0)
        XCTAssertTrue(validateStatus == false, "Success")
        
    }
    
    func testValidationSuccess(){
        let validateStatus = viewModel!.validate(title: "Wakeup", timeInterval: 60.0)
        XCTAssertTrue(validateStatus == true, "Success")
        
    }
    
    func testValidateLocalNotificationObject(){
        let notificationRequest = viewModel!.createLocalNotificationRequest(title: "Wake up", timeInterval: 60.0)
        let title = notificationRequest.content.title
        XCTAssert(title == "Wake up", "Success")
        
    }
    
    func testUserOptedInPermission(){
        
        let expectationTest = expectation(description: "test")

        self.localNotificationScheduler?.userOptedInForLocalNotifications {  status in
            XCTAssert(status == true, "Success")
            expectationTest.fulfill()
        }
        self.waitForExpectations(timeout: 5)
        
    }
    
    func testUserOptedInPermissionWithSemaphore(){
        self.localNotificationScheduler?.userOptedInForLocalNotifications {  status in
            XCTAssert(status == true, "Success")
            self.semaphore.signal()
            
        }
        self.semaphore.wait()
        
    }
    
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
