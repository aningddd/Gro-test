//
//  backEndData.swift
//  BackEndTest
//
//  Created by Bowen一一＂一 yang一一 on 11/7/22.
//

import Foundation
import UIKit
public struct UserData {
    var type:String
    var description:String
    var avatar: UIImage
    var userName: String
    var url:String
    var email: String
}

public struct EventData {
    var orgName:String
    var eventName:String
    var description:String
    var image: UIImage
    var position_x: Float
    var position_y: Float
    var url:String
    var eventLocation: String
    var year: String
    var month:String
    var date:String
    var time: String
}

public struct userName_email{
    var userName: String
    var email: String
}

