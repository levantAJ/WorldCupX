//
//  Player.swift
//  WorldCupX
//
//  Created by AJ on 6/18/14.
//  Copyright (c) 2014 ATteam. All rights reserved.
//

import Foundation

class Player: NSObject{
    var firstName: String?
    var lastName: String?
    var nickname: String?
    var nationality: String?
    var age: Int?
    var birthDate: String?
    var birthCountry: String?
    var birthCity: String?
    var position: String?
    var foot: String?
    var image: String?
    var heightCm: Int?
    var weightKg: Int?
    var goals: Int?
    var ownGoals: Int?
    var penaltyGoals: Int?
    var assists: Int?
    var clubId: String?
    var teamId: String?
    var id: String?
    var type: String?
    
    init(firstName: AnyObject, lastName: AnyObject, nickname: AnyObject, nationality: AnyObject, age: AnyObject, birthDate: AnyObject, birthCountry: AnyObject, birthCity: AnyObject, position: AnyObject, foot: AnyObject, image: AnyObject, heightCm: AnyObject, weightKg: AnyObject, goals: AnyObject, ownGoals: AnyObject, penaltyGoals: AnyObject, assists: AnyObject, clubId: AnyObject, teamId: AnyObject, id: AnyObject, type: AnyObject) {
        self.firstName = firstName as? String
        self.lastName = lastName as? String
        self.nickname = nickname as? String
        self.nationality = nationality as? String
        self.age = age as? Int
        self.birthDate = birthDate as? String
        self.birthCountry = birthCountry as? String
        self.birthCity = birthCity as? String
        self.position = position as? String
        self.foot = foot as? String
        self.image = image as? String
        self.heightCm = heightCm as? Int
        self.weightKg = weightKg as? Int
        self.goals = goals as? Int
        self.ownGoals = ownGoals as? Int
        self.penaltyGoals = penaltyGoals as? Int
        self.assists = assists as? Int
        self.clubId = clubId as? String
        self.teamId = teamId as? String
        self.id = id as? String
        self.type = type as? String
    }
    
    class func get(data: NSMutableArray, id: String) -> Player{
        var predicate: NSPredicate = NSPredicate(format: "id contains[c] %@", id)
        return (data.filteredArrayUsingPredicate(predicate))[0] as Player
    }
    
    init() {
        
    }
    
    
//    init(firstName: String, lastName: String, nickname: String, nationality: String, age: Int, birthDate: String, birthCountry: String, birthCity: String, position: String, foot: String, image: String, heightCm: Float, weightKg: Float, goals: Int, ownGoals: Int, penaltyGoals: Int, assists: Int, clubId: String, teamId: String, id: String, type: String) {
//        self.firstName = firstName
//        self.lastName = lastName
//        self.nickname = nickname
//        self.nationality = nationality
//        self.age = age
//        self.birthDate = birthDate
//        self.birthCountry = birthCountry
//        self.birthCity = birthCity
//        self.position = position
//        self.foot = foot
//        self.image = image
//        self.heightCm = heightCm
//        self.weightKg = weightKg
//        self.goals = goals
//        self.ownGoals = ownGoals
//        self.penaltyGoals = penaltyGoals
//        self.assists = assists
//        self.clubId = clubId
//        self.teamId = teamId
//        self.id = id
//        self.type = type
//    }
}