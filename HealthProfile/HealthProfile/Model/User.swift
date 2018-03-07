//
//  User.swift
//  HealthProfile
//
//  Created by Gimin Moon on 2/17/18.
//  Copyright © 2018 Gimin Moon. All rights reserved.
//

import Foundation

class User {
    var Email : String = ""
    var Contacts: [User] = []
    var SharedList: [User] = []
    var SharingList: [User] = []
    var gender : Gender?
    var bloodtype: BloodType?
    //more to come
    
}

enum Gender{
    case Male
    case South
}

enum BloodType{
    case A
    case B
    case O
    case AB
}
