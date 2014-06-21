//
//  Club.swift
//  WorldCupX
//
//  Created by AJ on 6/16/14.
//  Copyright (c) 2014 ATteam. All rights reserved.
//

import Foundation

class Team : NSObject{
    var name: String
    var logo: String
    var foundedYear: Int
    var address: String
    var homeStadium: String
    var stadiumCapacity: Int
    var group: String
    var groupRank: Int
    var groupPoints: Int
    var matchesPlayed: Int
    var wins: Int
    var losses: Int
    var draws: Int
    var goalsFor: Int
    var goalsAgainst: Int
    var id: String
    var type: String
    var flag: String?
    var code: String?
    var website: String?
    var goalsDiff: String?
    
    
    init(name: String, logo: String, foundedYear: Int, address: String, homeStadium: String, stadiumCapacity: Int, group: String, groupRank: Int, groupPoints: Int, matchesPlayed: Int, wins: Int, losses: Int, draws: Int, goalsFor: Int, goalsAgainst: Int, id: String, type: String, website: String, goalsDiff: String) {
        self.name = name
        self.logo = logo
        self.foundedYear = foundedYear
        self.address = address
        self.homeStadium = homeStadium
        self.stadiumCapacity = stadiumCapacity
        self.group = group
        self.groupRank = groupRank
        self.groupPoints = groupPoints
        self.matchesPlayed = matchesPlayed
        self.wins = wins
        self.losses = losses
        self.draws = draws
        self.goalsFor = goalsFor
        self.goalsAgainst = goalsAgainst
        self.goalsDiff = goalsDiff
        self.id = id
        self.type = type
        var code = Utility.getCodeByCode(name.substringToIndex(3).lowercaseString)
        self.code = code
        self.flag = "http://img.fifa.com/images/flags/4/\(self.code).png"
        self.website = website
    }
    
    init(){
        self.name = ""
        self.logo = ""
        self.foundedYear = 0
        self.address = ""
        self.homeStadium = ""
        self.stadiumCapacity = 0
        self.group = ""
        self.groupRank = 0
        self.groupPoints = 0
        self.matchesPlayed = 0
        self.wins = 0
        self.losses = 0
        self.draws = 0
        self.goalsFor = 0
        self.goalsAgainst = 0
        self.id = ""
        self.type = ""
        self.flag = ""
        self.code = ""
        self.website = ""
        self.goalsDiff = "0"
        
    }
    
    
    class func get(data: NSMutableArray, id: String) -> Team?{
        var predicate: NSPredicate = NSPredicate(format: "id contains[c] %@", id)
        var array: NSArray = data.filteredArrayUsingPredicate(predicate)
        if array.count > 0{
            return (array.objectAtIndex(0) as? Team)
        }
        return nil
    }
    
    class func getNameById(data: NSMutableArray, id: String) -> String{
        var predicate: NSPredicate = NSPredicate(format: "id contains[c] %@", id)
        var array: NSArray = data.filteredArrayUsingPredicate(predicate)
        if array.count>0{
            return (array.objectAtIndex(0) as Team).name
        }
        return ""
    }
}
