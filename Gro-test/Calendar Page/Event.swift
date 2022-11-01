//
//  Event.swift
//  Gro-test
//
//  Created by Long Do on 10/30/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import Foundation

class Event {
    var eventName:String?
    var orgName:String?
    var time:String?
    let errorCode:String = "404"
    
    init(eventName:String, orgName:String, time:String) {
        self.eventName = eventName
        self.orgName = orgName
        self.time = time
    }
    
    func getEventName() -> String {
        if let eventName = self.eventName {
            return eventName
        }
        return errorCode
    }
    
    func getOrgName() -> String {
        if let orgName = self.orgName {
            return orgName
        }
        return errorCode
    }
    
    func getTime() -> String {
        if let time = self.time {
            return time
        }
        return errorCode
    }
    
    func setEventName(eventName:String) -> Void {
        self.eventName = eventName
    }
    
    func setOrgname(orgName:String) -> Void {
        self.orgName = orgName
    }
    
    func setTime(time:String) -> Void {
        self.time = time
    }
}
