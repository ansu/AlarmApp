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

extension XCTestCase {
    
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        
        // We use a buffer here to avoid flakiness with Timer on CI
        waitForExpectations(timeout: duration + 0.5)
    }
}

class AlarmAppTests: XCTestCase {
    
    var viewModel:AlarmViewModel?

    override func setUp() {
        super.setUp()
        viewModel = AlarmViewModelling()

        // Put setup code here. This method is called before the invocation of each test method in the class.
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
