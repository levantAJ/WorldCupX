//
//  SecondViewController.swift
//  WorldCupX
//
//  Created by AJ on 6/16/14.
//  Copyright (c) 2014 ATteam. All rights reserved.
//

import UIKit

var instance: MatchViewController? = nil

class MatchViewController: UIViewController, NSURLConnectionDelegate {
    
    //    var tableData: NSMutableArray = NSMutableArray()
    var teamData: NSMutableArray = NSMutableArray()
    var topScoredData: NSMutableArray = NSMutableArray()
    var tableDict: NSMutableDictionary = NSMutableDictionary()
    var tableTitle: NSMutableArray = NSMutableArray()
    var selectedMatch: Match = Match()
    
    @IBOutlet var tableView: UITableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        self.getTeamData()
        instance = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    class func sharedInstance() -> MatchViewController? {
        return instance;
    }
    
    ///// GET DATA
    func getData(){
        //        self.tableData = NSMutableArray()
        self.tableTitle = NSMutableArray()
        self.tableDict = NSMutableDictionary()
        var link: String = "http://worldcup.kimonolabs.com/api/matches?sort=startTime&apikey=bc6d6fac9954d187d0706e4f9aeb26c6&kimnocall=1"
        var url: NSURL = NSURL(string: link)
        let manager = AFHTTPRequestOperationManager()
        manager.GET(
            link,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let values = responseObject as NSArray
                for obj : AnyObject in values{
                    var match: Match = Match(homeScore: obj.objectForKey("homeScore"), awayScore: obj.objectForKey("awayScore"), currentGameMinute: obj.objectForKey("currentGameMinute"), startTime: obj.objectForKey("startTime"), status: obj.objectForKey("status"), venue: obj.objectForKey("venue"), group: obj.objectForKey("group"), awayTeamId: obj.objectForKey("awayTeamId"), homeTeamId: obj.objectForKey("homeTeamId"), id: obj.objectForKey("id"), type: obj.objectForKey("type"))
                    
                    var date: String? = obj.objectForKey("startTime") as? String
                    date = Utility.convertDateToString(Utility.convertStringToDate(date!), format: "MMM dd, YYYY")
                    if !self.tableTitle.containsObject(date){
                        self.tableTitle.addObject(date)
                    }
                    var temp: NSMutableArray
                    if  nil == self.tableDict.objectForKey(date) {
                        temp = NSMutableArray(object: match)
                    }else{
                        temp = self.tableDict.objectForKey(date) as NSMutableArray
                        temp.addObject(match)
                    }
                    self.tableDict.setValue(temp, forKey: date)
                }
                self.tableTitle.sortUsingComparator({obj1, obj2 in
                    var c1 = Utility.convertStringToDate(obj1 as String)
                    var c2 = Utility.convertStringToDate(obj2 as String)
                    return c1.compare(c2)
                    })
                self.tableView.reloadData()
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
            })
    }
    func getTeamData(){
        self.teamData = NSMutableArray()
        var link: String = "http://worldcup.kimonolabs.com/api/teams?sort=name&apikey=bc6d6fac9954d187d0706e4f9aeb26c6&kimnocall=1"
        var url: NSURL = NSURL(string: link)
        let manager = AFHTTPRequestOperationManager()
        manager.GET(
            link,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let values = responseObject as NSArray
                for obj : AnyObject in values{
                    var team: Team = Team(name: obj.objectForKey("name") as String, logo: obj.objectForKey("logo") as String, foundedYear: obj.objectForKey("foundedYear") as Int, address: obj.objectForKey("address") as String, homeStadium: obj.objectForKey("homeStadium") as String, stadiumCapacity: obj.objectForKey("stadiumCapacity") as Int, group: obj.objectForKey("group") as String, groupRank: obj.objectForKey("groupRank") as Int, groupPoints: obj.objectForKey("groupPoints") as Int, matchesPlayed: obj.objectForKey("matchesPlayed") as Int, wins: obj.objectForKey("wins") as Int, losses: obj.objectForKey("losses") as Int, draws: obj.objectForKey("draws") as Int, goalsFor: obj.objectForKey("goalsFor") as Int, goalsAgainst: obj.objectForKey("goalsAgainst") as Int, id: obj.objectForKey("id") as String, type: obj.objectForKey("type") as String, website: obj.objectForKey("website") as String, goalsDiff: obj.objectForKey("goalsDiff") as String)
                    self.teamData.addObject(team)
                    self.getTopScoredData(team.id)
                }
                
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
            })
    }
    func getTopScoredData(teamId: String){
        self.topScoredData = NSMutableArray()
        var link: String = "http://worldcup.kimonolabs.com/api/players?sort=firstName&teamId=\(teamId)&apikey=bc6d6fac9954d187d0706e4f9aeb26c6&kimnocall=1"
        var url: NSURL = NSURL(string: link)
        let manager = AFHTTPRequestOperationManager()
        manager.GET(
            link,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let values = responseObject as NSArray
                for obj : AnyObject in values{
                    var goals = obj.objectForKey("goals") as Int
                    if goals>0{
                        var player = Player(firstName: obj.objectForKey("firstName"), lastName: obj.objectForKey("lastName"), nickname: obj.objectForKey("nickname"), nationality: obj.objectForKey("nationality"), age: obj.objectForKey("age"), birthDate: obj.objectForKey("birthDate"), birthCountry: obj.objectForKey("birthCountry"), birthCity: obj.objectForKey("birthCity"), position: obj.objectForKey("position"), foot: obj.objectForKey("foot"), image: obj.objectForKey("image"), heightCm: obj.objectForKey("heightCm"), weightKg: obj.objectForKey("weightKg"), goals: obj.objectForKey("goals"), ownGoals: obj.objectForKey("ownGoals"), penaltyGoals: obj.objectForKey("penaltyGoals"), assists: obj.objectForKey("assists"), clubId: obj.objectForKey("clubId"), teamId: obj.objectForKey("teamId"), id: obj.objectForKey("id"), type: obj.objectForKey("type"))
                        self.topScoredData.addObject(player)
                    }
                }
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
            })
    }
    
    
    //////// UITableView
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int{
        return self.tableTitle.count
    }
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        //        return tableData.count
        if self.tableTitle.count>0{
            var sectionTitle: String = self.tableTitle.objectAtIndex(section) as String
            var array: AnyObject = self.tableDict.objectForKey(sectionTitle)
            return array.count
        }
        return 0
    }
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String{
        if self.tableTitle.count>0{
            return self.tableTitle.objectAtIndex(section) as String
        }
        return ""
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let reuseIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? MatchTableViewCell
        
        if !cell {
            var nib: NSArray = NSBundle.mainBundle().loadNibNamed("MatchTableViewCell", owner: self, options: nil)
            cell = nib.objectAtIndex(0) as? MatchTableViewCell
            //            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier:reuseIdentifier)
        }
        
        var sectionTitle: String = self.tableTitle.objectAtIndex(indexPath.section) as String
        var sectionClubs: NSArray = self.tableDict.objectForKey(sectionTitle) as NSArray
        //        var club: Club = self.tableData.objectAtIndex(indexPath.row) as Club
        var match: Match = sectionClubs.objectAtIndex(indexPath.row) as Match
        var home = Team.get(self.teamData, id: match.homeTeamId!)
        var away = Team.get(self.teamData, id: match.awayTeamId!)
        
        cell!.imgHome.layer.borderWidth = 0.5
        cell!.imgHome.layer.borderColor = Utility.borderColor().CGColor
        cell!.imgAway.layer.borderWidth = 0.5
        cell!.imgAway.layer.borderColor = Utility.borderColor().CGColor
        
        if home is Team{
            cell!.imgHome.image = Utility.getImage(home!.flag!)
            cell!.lblHome.text = home!.name
        }
        if away is Team{
            cell!.imgAway.image = Utility.getImage(away!.flag!)
            cell!.lblAway.text = away!.name
        }
        var status:String = match.status!
        if status=="Final"{
            status = "Full-time"
        }
        cell!.lblGroupStatus.text = "\(status) - Group \(match.group)"
        cell!.lblScore.text = "\(match.homeScore) - \(match.awayScore)"
        cell!.lblTime.text = Utility.convertDateToString(match.startTime!, format: "HH:mm")
        
        cell!.selectedBackgroundView = Utility.selectedCell()
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        //        var sectionTitle: String = self.tableTitle.objectAtIndex(indexPath.section) as String
        //        var sectionClubs: NSArray = self.tableDict.objectForKey(sectionTitle) as NSArray
        //        self.selectedTeam = sectionClubs.objectAtIndex(indexPath.row) as Team
        //        self.performSegueWithIdentifier("playerInTeam", sender: self.view)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        //        if segue.identifier=="playerInTeam" {
        //            self.view.endEditing(true)
        //            (segue.destinationViewController as PlayerViewController).setDetailItem(selectedTeam)
        //        }
    }
}

