//
//  SecondViewController.swift
//  WorldCupX
//
//  Created by AJ on 6/16/14.
//  Copyright (c) 2014 ATteam. All rights reserved.
//

import UIKit



class TeamDetailsViewController: UIViewController, NSURLConnectionDelegate {
    
    var tableData: NSMutableArray = NSMutableArray()
    var selectedTeam: Team = Team()
    
    @IBOutlet var tableView: UITableView
    @IBOutlet var navTitle: UINavigationItem
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle.title = self.selectedTeam.name
        self.processData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setDetailItem(selectedTeam: Team){
        self.selectedTeam = selectedTeam
    }
    
    func processData(){
        tableData.addObject(Utility(key: "Name", value: self.selectedTeam.name))
//        tableData.addObject(Utility(key: "Logo", value: self.selectedTeam.logo))
        tableData.addObject(Utility(key: "Website", value: self.selectedTeam.website!))
        tableData.addObject(Utility(key: "Founded Year", value: "\(self.selectedTeam.foundedYear)"))
        tableData.addObject(Utility(key: "Address", value: self.selectedTeam.address))
        tableData.addObject(Utility(key: "Home Stadium", value: self.selectedTeam.homeStadium))
        tableData.addObject(Utility(key: "Stadium Capacity", value: "\(self.selectedTeam.stadiumCapacity)"))
        tableData.addObject(Utility(key: "Group", value: self.selectedTeam.group))
        tableData.addObject(Utility(key: "Group Rank", value: "\(self.selectedTeam.groupRank)"))
        tableData.addObject(Utility(key: "Group Points", value: "\(self.selectedTeam.groupPoints)"))
        tableData.addObject(Utility(key: "Matches Played", value: "\(self.selectedTeam.matchesPlayed)"))
        tableData.addObject(Utility(key: "Wins", value: "\(self.selectedTeam.wins)"))
        tableData.addObject(Utility(key: "Losses", value: "\(self.selectedTeam.losses)"))
        tableData.addObject(Utility(key: "Draw", value: "\(self.selectedTeam.draws)"))
        tableData.addObject(Utility(key: "Goals For", value: "\(self.selectedTeam.goalsFor)"))
        tableData.addObject(Utility(key: "Goals Against", value: "\(self.selectedTeam.goalsAgainst)"))
        tableData.addObject(Utility(key: "Goals Diff", value: self.selectedTeam.goalsDiff!))
    }
    
    //////// UITableView
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return self.tableData.count
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let reuseIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? UITableViewCell
        
        if !cell {
            cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier:reuseIdentifier)
        }
        var team: Utility = self.tableData.objectAtIndex(indexPath.row) as Utility
        cell!.textLabel.text = team.key
        cell!.detailTextLabel.text = team.value
        cell!.selectedBackgroundView = Utility.selectedCell()
        return cell
    }
    
    func teamDetails(){
        self.performSegueWithIdentifier("teamDetails", sender: self.view)
    }
}

