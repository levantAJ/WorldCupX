//
//  Player.swift
//  WorldCupX
//
//  Created by AJ on 6/18/14.
//  Copyright (c) 2014 ATteam. All rights reserved.
//

import Foundation

class Match: NSObject{
    var homeScore: Int?
    var awayScore: Int?
    var currentGameMinute: Int?
    var startTime: NSDate?
    var status: String?
    var venue: String?
    var group: String?
    var awayTeamId: String?
    var homeTeamId: String?
    var id: String?
    var type: String?
    
    
    init(homeScore: AnyObject, awayScore: AnyObject, currentGameMinute: AnyObject, startTime: AnyObject, status: AnyObject, venue: AnyObject, group: AnyObject, awayTeamId: AnyObject, homeTeamId: AnyObject, id: AnyObject, type: AnyObject) {
        self.homeScore = homeScore as? Int
        self.awayScore = awayScore as? Int
        self.currentGameMinute = currentGameMinute as? Int
        self.startTime = Utility.convertStringToDate(startTime as String)
        self.status = status as? String
        self.venue = venue as? String
        self.group = group as? String
        self.awayTeamId = awayTeamId as? String
        self.homeTeamId = homeTeamId as? String
        self.id = id as? String
        self.type = type as? String
    }
    
    init() {
        homeScore = 0
        awayScore = 0
        currentGameMinute = 0
        startTime = NSDate()
        status = ""
        venue = ""
        group = ""
        awayTeamId = ""
        homeTeamId = ""
        id = ""
        type = ""
    }
    
    
    class func get(data: NSMutableArray, id: String) -> Match{
        var predicate: NSPredicate = NSPredicate(format: "id contains[c] %@", id)
        return (data.filteredArrayUsingPredicate(predicate))[0] as Match
    }
    
}