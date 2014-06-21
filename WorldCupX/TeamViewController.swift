//
//  SecondViewController.swift
//  WorldCupX
//
//  Created by AJ on 6/16/14.
//  Copyright (c) 2014 ATteam. All rights reserved.
//

import UIKit



class TeamViewController: UIViewController, NSURLConnectionDelegate {
    
    var tableData: NSMutableArray = NSMutableArray()
    var tableDict: NSMutableDictionary = NSMutableDictionary()
    var tableTitle: NSMutableArray = NSMutableArray()
    var selectedTeam: Team = Team()
    var currentIndexPath: NSIndexPath = NSIndexPath(forRow: -1, inSection: -1)
    var currentTableViewCell: TeamTableViewCell?
    
    @IBOutlet var tableView: UITableView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var matchViewController: MatchViewController = MatchViewController.sharedInstance()!
        tableData = matchViewController.teamData
        //        self.getData()
        self.processData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///// GET DATA
    func processData(){
        var team: Team
        for obj : AnyObject in self.tableData{
            team = obj as Team
            if !self.tableTitle.containsObject(team.group){
                self.tableTitle.addObject(team.group)
            }
            var temp: NSMutableArray
            if  nil == self.tableDict.objectForKey(team.group) {
                temp = NSMutableArray(object: team)
            }else{
                temp = self.tableDict.objectForKey(team.group) as NSMutableArray
                temp.addObject(team)
                temp.sortUsingComparator({obj1, obj2 in
                    var t1 = obj1 as Team
                    var t2 = obj2 as Team
                    if t1.groupRank<t2.groupRank{
                        return NSComparisonResult.OrderedAscending
                    }
                    return NSComparisonResult.OrderedDescending
                    })
            }
            self.tableDict.setValue(temp, forKey: team.group)
        }
        self.tableTitle.sortUsingComparator({obj1, obj2 in
            var c1 = obj1 as String
            var c2 = obj2 as String
            return c1.compare(c2)
            })
        self.tableView.reloadData()
    }
    
    func getData(){
        //        self.tableData = NSMutableArray()
        self.tableTitle = NSMutableArray()
        self.tableDict = NSMutableDictionary()
        var link: String = "http://worldcup.kimonolabs.com/api/teams?sort=name&apikey=bc6d6fac9954d187d0706e4f9aeb26c6&kimnocall=1"
        var url: NSURL = NSURL(string: link)
        let manager = AFHTTPRequestOperationManager()
        manager.GET(
            link,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let values = responseObject as NSArray
                for obj : AnyObject in values{
                    var club: Team = Team(name: obj.objectForKey("name") as String, logo: obj.objectForKey("logo") as String, foundedYear: obj.objectForKey("foundedYear") as Int, address: obj.objectForKey("address") as String, homeStadium: obj.objectForKey("homeStadium") as String, stadiumCapacity: obj.objectForKey("stadiumCapacity") as Int, group: obj.objectForKey("group") as String, groupRank: obj.objectForKey("groupRank") as Int, groupPoints: obj.objectForKey("groupPoints") as Int, matchesPlayed: obj.objectForKey("matchesPlayed") as Int, wins: obj.objectForKey("wins") as Int, losses: obj.objectForKey("losses") as Int, draws: obj.objectForKey("draws") as Int, goalsFor: obj.objectForKey("goalsFor") as Int, goalsAgainst: obj.objectForKey("goalsAgainst") as Int, id: obj.objectForKey("id") as String, type: obj.objectForKey("type") as String, website: obj.objectForKey("website") as String, goalsDiff: obj.objectForKey("goalsDiff") as String)
                    //                    self.tableData.addObject(club)
                    
                    if !self.tableTitle.containsObject(club.group){
                        self.tableTitle.addObject(club.group)
                    }
                    
                    var temp: NSMutableArray
                    if  nil == self.tableDict.objectForKey(club.group) {
                        temp = NSMutableArray(object: club)
                    }else{
                        temp = self.tableDict.objectForKey(club.group) as NSMutableArray
                        temp.addObject(club)
                    }
                    self.tableDict.setValue(temp, forKey: club.group)
                }
                //                self.tableData.sortUsingComparator({obj1, obj2 in
                //                    var c1 = obj1 as Club
                //                    var c2 = obj2 as Club
                //                    return c1.group.compare(c2.group)
                //                    })
                self.tableTitle.sortUsingComparator({obj1, obj2 in
                    var c1 = obj1 as String
                    var c2 = obj2 as String
                    return c1.compare(c2)
                    })
                self.tableView.reloadData()
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
            return "Group \(self.tableTitle.objectAtIndex(section) as String)"
        }
        return ""
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let reuseIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? TeamTableViewCell
        
        if !cell {
            var nib: NSArray = NSBundle.mainBundle().loadNibNamed("TeamTableViewCell", owner: self, options: nil)
            cell = nib.objectAtIndex(0) as? TeamTableViewCell
            //            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier:reuseIdentifier)
        }
        
        var sectionTitle: String = self.tableTitle.objectAtIndex(indexPath.section) as String
        var sectionClubs: NSArray = self.tableDict.objectForKey(sectionTitle) as NSArray
        //        var club: Club = self.tableData.objectAtIndex(indexPath.row) as Club
        var club: Team = sectionClubs.objectAtIndex(indexPath.row) as Team
        
        //        cell!.text = club.name
        cell!.lblName.text = club.name
        //        cell!.detailTextLabel.text = "Wins: \(club.wins) Draws: \(club.draws) Losses: \(club.losses)"
        cell!.lblDetails.text = "Wins: \(club.wins) Draws: \(club.draws) Losses: \(club.losses)"
        
        //        cell!.imageView.image = Utility.getImage(club.flag!, newSize: CGSize(width: 37, height: 24))
        //        cell!.imageView.clipsToBounds = true
        //        cell!.imageView.layer.borderWidth = 0.5
        //        cell!.imageView.layer.borderColor = Utility.borderColor().CGColor
        
        cell!.imgFlag.image = Utility.getImage(club.flag!)
        cell!.imgFlag.clipsToBounds = true
        cell!.imgFlag.layer.borderWidth = 0.5
        cell!.imgFlag.layer.borderColor = Utility.borderColor().CGColor
        
        //        let image = UIImage(named: "user.png") as UIImage
        let image = Utility.getImage(club.logo)
        //        let button   = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        //        button.frame = CGRectMake(0, 0, 27, 27)
        //        button.setImage(image, forState: .Normal)
        //        button.setTitle(club.id, forState: .Normal)
        //        button.setTitleColor(UIColor.clearColor(), forState: .Normal)
        //        button.addTarget(self, action: Selector("teamDetails:"), forControlEvents:.TouchUpInside)
        //        cell!.accessoryView = button
        
        cell!.btnFC.setImage(image, forState: .Normal)
        cell!.btnFC.setBackgroundImage(image, forState: .Normal)
        cell!.btnFC.setTitle("\(club.id)#\(indexPath.section)#\(indexPath.row)", forState: .Normal)
        cell!.btnFC.setTitleColor(UIColor.clearColor(), forState: .Normal)
        cell!.btnFC.addTarget(self, action: Selector("teamDetails:"), forControlEvents:.TouchUpInside)
        cell!.btnFC.tag = 1
        
        ///// Details
        cell!.lblWebsite.text = "Website: \(club.website)"
        cell!.lblAddress.text = "Address: \(club.address)"
        cell!.lblCapacity.text = "Capacity: \(club.stadiumCapacity)"
        cell!.lblGroup.text = "Group: \(club.group) Rank: \(club.groupRank) Points: \(club.groupPoints)"
        cell!.lblMatch.text = "Matches played: \(club.matchesPlayed)"
        cell!.lblStadium.text = "Stadium: \(club.homeStadium)"
        cell!.lblPoint.text = "Goals For: \(club.goalsFor) Goals Against: \(club.goalsAgainst) Goals Diff: \(club.goalsDiff)"
        cell!.lblYear.text = "Year: \(club.foundedYear)"
        
        cell!.btnPlayers.addTarget(self, action: Selector("teamDetails:"), forControlEvents:.TouchUpInside)
        cell!.btnPlayers.layer.cornerRadius = 2
        cell!.btnPlayers.layer.borderColor = cell!.btnPlayers.tintColor.CGColor
        cell!.btnPlayers.layer.borderWidth = 0.5
        cell!.btnPlayers.tag = 2
        cell!.btnPlayers.backgroundColor = Utility.purpleColor()
        
        cell!.selectedBackgroundView = Utility.selectedCell()
        return cell
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat{
        if indexPath.row==self.currentIndexPath.row && indexPath.section==self.currentIndexPath.section{
            currentTableViewCell!.hideDetails()
            return 195
        }
        if currentTableViewCell is TeamTableViewCell{
            currentTableViewCell!.showDetails()
        }
        return 44;
    }
    
    func teamDetails(sender: UIButton!){
        var data: String[]
        if sender.tag==1{
            data = sender.titleLabel.text.componentsSeparatedByString("#")
        }else{
            data = self.currentTableViewCell!.btnFC.titleLabel.text.componentsSeparatedByString("#")
        }
        self.selectedTeam = Team.get(self.tableData, id: data[0])!
        self.currentIndexPath = NSIndexPath(forRow: String(data[2]).toInt()!, inSection: String(data[1]).toInt()!)
        self.performSegueWithIdentifier("playerInTeam", sender: self.view)
    }
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        var sectionTitle: String = self.tableTitle.objectAtIndex(indexPath.section) as String
        var sectionClubs: NSArray = self.tableDict.objectForKey(sectionTitle) as NSArray
        self.selectedTeam = sectionClubs.objectAtIndex(indexPath.row) as Team
        if currentTableViewCell is TeamTableViewCell{
            currentTableViewCell!.hideDetails()
        }
        currentTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as? TeamTableViewCell
//        self.performSegueWithIdentifier("playerInTeam", sender: self.view)
        self.currentIndexPath = indexPath
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier=="playerInTeam" {
            self.view.endEditing(true)
            (segue.destinationViewController as PlayerViewController).setDetailItem(selectedTeam)
        }
        if segue.identifier=="teamDetails" {
            self.view.endEditing(true)
            (segue.destinationViewController as TeamDetailsViewController).setDetailItem(selectedTeam)
        }
    }
}

