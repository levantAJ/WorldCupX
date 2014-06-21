//
//  TeamViewController.swift
//  WorldCupX
//
//  Created by AJ on 6/18/14.
//  Copyright (c) 2014 ATteam. All rights reserved.
//

import UIKit
import QuartzCore

class PlayerViewController: UIViewController, NSURLConnectionDelegate {
    
    var tableData: NSMutableArray = NSMutableArray()
    //    var tableDict: NSMutableDictionary = NSMutableDictionary()
    //    var tableTitle: NSMutableArray = NSMutableArray()
    
    @IBOutlet var tableView: UITableView
    @IBOutlet var navTitle: UINavigationItem
    var currentIndexPath: NSIndexPath = NSIndexPath(forRow: -1, inSection: -1)
    var currentTableViewCell: PlayerTableViewCell?
    var selectedPlayer: Player = Player()
    
    var selectedTeam: Team = Team()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        self.navTitle.title = self.selectedTeam.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setDetailItem(selectedTeam: Team){
        self.selectedTeam = selectedTeam
    }
    
    ///// GET DATA
    func getData(){
        self.tableData = NSMutableArray()
        //        self.tableTitle = NSMutableArray()
        //        self.tableDict = NSMutableDictionary()
        var link: String = "http://worldcup.kimonolabs.com/api/players?sort=firstName&teamId=\(self.selectedTeam.id)&apikey=bc6d6fac9954d187d0706e4f9aeb26c6&kimnocall=1"
        var url: NSURL = NSURL(string: link)
        let manager = AFHTTPRequestOperationManager()
        manager.GET(
            link,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let values = responseObject as NSArray
                for obj : AnyObject in values{
                    //                    var objString: String = "\(obj)"
                    //                    println(objString)
                    var player = Player(firstName: obj.objectForKey("firstName"), lastName: obj.objectForKey("lastName"), nickname: obj.objectForKey("nickname"), nationality: obj.objectForKey("nationality"), age: obj.objectForKey("age"), birthDate: obj.objectForKey("birthDate"), birthCountry: obj.objectForKey("birthCountry"), birthCity: obj.objectForKey("birthCity"), position: obj.objectForKey("position"), foot: obj.objectForKey("foot"), image: obj.objectForKey("image"), heightCm: obj.objectForKey("heightCm"), weightKg: obj.objectForKey("weightKg"), goals: obj.objectForKey("goals"), ownGoals: obj.objectForKey("ownGoals"), penaltyGoals: obj.objectForKey("penaltyGoals"), assists: obj.objectForKey("assists"), clubId: obj.objectForKey("clubId"), teamId: obj.objectForKey("teamId"), id: obj.objectForKey("id"), type: obj.objectForKey("type"))
                    self.tableData.addObject(player)
                }
                self.tableView.reloadData()
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
            })
    }
    
    
    //////// UITableView
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return tableData.count
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
        //        cell!.text = "\(player.firstName) \(player.lastName)"
        //        cell!.detailTextLabel.text = "Goals: \(player.goals) Age: \(player.age) \(player.position)"
        //        cell!.imageView.image = Utility.getImage(player.image!, newSize: CGSize(width: 37, height: 37))
        //        cell!.imageView.clipsToBounds = true
        //        cell!.imageView.layer.cornerRadius = 18.5
        //        cell!.imageView.layer.borderWidth = 0.5
        //        cell!.imageView.layer.borderColor = Utility.borderColor().CGColor
        
        cell!.lblName.text = "\(player.firstName) \(player.lastName)"
        cell!.lblDetails.text = "Goals: \(player.goals) Age: \(player.age) \(player.position)"
        cell!.imgAvatar.image = Utility.getImage(player.image!)
        cell!.imgAvatar.clipsToBounds = true
        cell!.imgAvatar.layer.cornerRadius = 18.5
        cell!.imgAvatar.layer.borderWidth = 0.5
        cell!.imgAvatar.layer.borderColor = Utility.borderColor().CGColor
        
        //// Details
        cell!.lblNickname.text = "Nickname: \(player.nickname)"
        cell!.lblNationality.text = "Nationality: \(player.nationality)"
        var date = Utility.convertStringToDate(player.birthDate!)
        var dateString = Utility.convertDateToString(date, format: "MMM dd, YYYY")
        cell!.lblBirthday.text = "Birthday: \(dateString)"
        cell!.lblGoals.text = "Goals: \(player.goals) Own goals: \(player.ownGoals) Penalty goals: \(player.penaltyGoals) Assists: \(player.assists)"
        cell!.lblBody.text = "Weight: \(player.weightKg)kg Height: \(player.heightCm)cm Foot: \(player.foot)"
        
        cell!.selectedBackgroundView = Utility.selectedCell()
        
        cell!.btnStatus.layer.cornerRadius = 15.5
        cell!.btnStatus.layer.borderWidth = 1
        cell!.btnStatus.layer.borderColor = Utility.borderColor().CGColor
        cell!.btnStatus.clipsToBounds = true
        
        if player.goals > 0 || player.ownGoals > 0{
            cell!.btnStatus.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            cell!.btnStatus.setTitle("\(player.goals)", forState: .Normal)
            if player.goals>=1 && player.goals<3{
                cell!.btnStatus.layer.borderColor = Utility.orangeColor().CGColor
                cell!.btnStatus.backgroundColor = Utility.orangeColor()
            }
            if player.ownGoals>0{
                cell!.btnStatus.setTitle("-\(player.ownGoals)", forState: .Normal)
                cell!.btnStatus.layer.borderColor = Utility.purpleColor().CGColor
                cell!.btnStatus.backgroundColor = Utility.purpleColor()
            }
            if player.goals>=3{
                cell!.btnStatus.layer.borderColor = Utility.greenColor().CGColor
                cell!.btnStatus.backgroundColor = Utility.greenColor()
            }
        }
        
        
        //        var image = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        //        image.backgroundColor = UIColor.whiteColor()
        //        if player.goals>=1 && player.goals<3{
        //            image.backgroundColor = Utility.orangeColor()
        //        }
        //        if player.goals<0{
        //            image.backgroundColor = Utility.purpleColor()
        //        }
        //        if player.goals>=3{
        //            image.backgroundColor = Utility.greenColor()
        //        }
        //        image.layer.cornerRadius = 9
        //        cell!.accessoryView = image
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
