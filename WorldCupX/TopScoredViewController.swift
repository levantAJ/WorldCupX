//
//  SecondViewController.swift
//  WorldCupX
//
//  Created by AJ on 6/16/14.
//  Copyright (c) 2014 ATteam. All rights reserved.
//

import UIKit
import QuartzCore

class TopScoredViewController: UIViewController, NSURLConnectionDelegate {
    
    var tableData: NSMutableArray = NSMutableArray()
    var matchViewController = MatchViewController()
    var currentIndexPath: NSIndexPath = NSIndexPath(forRow: -1, inSection: -1)
    var currentTableViewCell: PlayerTableViewCell?
    var selectedPlayer: Player = Player()
    
    @IBOutlet var tableView: UITableView
    @IBOutlet var navTitle: UINavigationItem
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.processData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func processData(){
        self.matchViewController = MatchViewController.sharedInstance() as MatchViewController
        self.tableData = matchViewController.topScoredData
        self.tableData.sortUsingComparator({obj1, obj2 in
            var p1 = obj1 as Player
            var p2 = obj2 as Player
            
            if p1.goals>p2.goals{
                return NSComparisonResult.OrderedAscending
            }
            return NSComparisonResult.OrderedDescending
            })
        
        var count: Int = self.tableData.count
        if count>10{
            count=10
        }
        
        self.tableData.removeObjectsInRange(NSRange(location: count, length: self.tableData.count-count))
        self.tableView.reloadData()
//        self.tableData.subarrayWithRange(NSRange(location: 0, length: count))
    }
    
    //////// UITableView
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return self.tableData.count
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let reuseIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? PlayerTableViewCell
        
        if !cell {
//            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier:reuseIdentifier)
            var nib: NSArray = NSBundle.mainBundle().loadNibNamed("PlayerTableViewCell", owner: self, options: nil)
            cell = nib.objectAtIndex(0) as? PlayerTableViewCell
        }
        var player: Player = self.tableData.objectAtIndex(indexPath.row) as Player
        var team = Team.get(self.matchViewController.teamData, id: player.teamId!) as Team
        
//        cell!.text = "\(player.firstName) \(player.lastName)"
        cell!.lblName.text = "\(player.firstName) \(player.lastName)"
//        cell!.detailTextLabel.text = "Goals: \(player.goals) \(player.position) \(team.name)"
        cell!.lblDetails.text = "Goals: \(player.goals) \(player.position) \(team.name)"
        
//        cell!.imageView.image = Utility.getImage(player.image!, newSize: CGSize(width: 37, height: 37))
//        cell!.imageView.clipsToBounds = true
//        cell!.imageView.layer.cornerRadius = 18.5
//        cell!.imageView.layer.borderWidth = 0.5
//        cell!.imageView.layer.borderColor = Utility.borderColor().CGColor
        
        cell!.imgAvatar.image = Utility.getImage(player.image!)
        cell!.imgAvatar.clipsToBounds = true
        cell!.imgAvatar.layer.cornerRadius = 18.5
        cell!.imgAvatar.layer.borderWidth = 0.5
        cell!.imgAvatar.layer.borderColor = Utility.borderColor().CGColor

        /// Details
        cell!.lblNickname.text = "Nickname: \(player.nickname)"
        cell!.lblNationality.text = "Nationality: \(player.nationality)"
        var date = Utility.convertStringToDate(player.birthDate!)
        var dateString = Utility.convertDateToString(date, format: "MMM dd, YYYY")
        cell!.lblBirthday.text = "Birthday: \(dateString)"
        cell!.lblGoals.text = "Goals: \(player.goals) Own goals: \(player.ownGoals) Penalty goals: \(player.penaltyGoals) Assists: \(player.assists)"
        cell!.lblBody.text = "Weight: \(player.weightKg)kg Height: \(player.heightCm)cm Foot: \(player.foot)"
        
        
//        var lblOrder = UILabel(frame: CGRect(x: 0, y: 0, width: 31, height: 31))
//        lblOrder.layer.borderColor = Utility.borderColor().CGColor
//        if indexPath.row==0{
//            lblOrder.layer.borderColor = Utility.greenColor().CGColor
//            lblOrder.backgroundColor = Utility.greenColor()
//        }
//        if indexPath.row==1{
//            lblOrder.layer.borderColor = Utility.orangeColor().CGColor
//            lblOrder.backgroundColor = Utility.orangeColor()
//        }
//        if indexPath.row==2{
//            lblOrder.layer.borderColor = Utility.blueColor().CGColor
//            lblOrder.backgroundColor = Utility.blueColor()
//        }
        
        //        lblOrder.layer.cornerRadius = 15.5
        //        lblOrder.layer.borderWidth = 1
        //        lblOrder.clipsToBounds = true
        //        lblOrder.text = "\(indexPath.row+1)"
        //        lblOrder.font.fontWithSize(41)
        //        lblOrder.textAlignment = .Center
        //        cell!.accessoryView = lblOrder
        
        cell!.btnStatus.layer.borderColor = Utility.borderColor().CGColor
        if indexPath.row==0{
            cell!.btnStatus.layer.borderColor = Utility.greenColor().CGColor
            cell!.btnStatus.backgroundColor = Utility.greenColor()
        }
        if indexPath.row==1{
            cell!.btnStatus.layer.borderColor = Utility.orangeColor().CGColor
            cell!.btnStatus.backgroundColor = Utility.orangeColor()
        }
        if indexPath.row==2{
            cell!.btnStatus.layer.borderColor = Utility.blueColor().CGColor
            cell!.btnStatus.backgroundColor = Utility.blueColor()
        }
        
        cell!.btnStatus.layer.cornerRadius = 15.5
        cell!.btnStatus.layer.borderWidth = 1
        cell!.btnStatus.clipsToBounds = true
        cell!.btnStatus.setTitle("\(indexPath.row+1)", forState: .Normal)
        cell!.btnStatus.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        cell!.btnStatus.font.fontWithSize(41)
        
        cell!.selectedBackgroundView = Utility.selectedCell()
        return cell
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat{
        if indexPath.row==self.currentIndexPath.row && indexPath.section==self.currentIndexPath.section{
            currentTableViewCell!.hideDetails()
            return 155
        }
        if currentTableViewCell is PlayerTableViewCell{
            currentTableViewCell!.showDetails()
        }
        return 44;
    }
    
    func teamDetails(){
        self.performSegueWithIdentifier("teamDetails", sender: self.view)
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.selectedPlayer = self.tableData.objectAtIndex(indexPath.row) as Player
        if currentTableViewCell is PlayerTableViewCell{
            currentTableViewCell!.hideDetails()
        }
        currentTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as? PlayerTableViewCell
        self.currentIndexPath = indexPath
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }

}

