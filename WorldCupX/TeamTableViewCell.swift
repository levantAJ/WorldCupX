//
//  MatchTableViewCell.swift
//  WorldCupX
//
//  Created by AJ on 6/19/14.
//  Copyright (c) 2014 ATteam. All rights reserved.
//

import UIKit

class TeamTableViewCell : UITableViewCell{
    @IBOutlet var lblName: UILabel
    @IBOutlet var lblDetails: UILabel
    @IBOutlet var imgFlag: UIImageView
    @IBOutlet var btnFC: UIButton
    @IBOutlet var btnPlayers: UIButton
    
    @IBOutlet var lblWebsite: UILabel
    @IBOutlet var lblAddress: UILabel
    @IBOutlet var lblStadium: UILabel
    @IBOutlet var lblCapacity: UILabel
    @IBOutlet var lblYear: UILabel
    @IBOutlet var lblGroup: UILabel
    @IBOutlet var lblMatch: UILabel
    @IBOutlet var lblPoint: UILabel
    
    func showDetails(){
        self.lblAddress.hidden = false
        self.lblCapacity.hidden = false
        self.lblGroup.hidden = false
        self.lblMatch.hidden = false
        self.lblPoint.hidden = false
        self.lblStadium.hidden = false
        self.lblWebsite.hidden = false
        self.lblYear.hidden = false
        self.btnPlayers.hidden = false
    }
    
    func hideDetails(){
        self.lblAddress.hidden = true
        self.lblCapacity.hidden = true
        self.lblGroup.hidden = true
        self.lblMatch.hidden = true
        self.lblPoint.hidden = true
        self.lblStadium.hidden = true
        self.lblWebsite.hidden = true
        self.lblYear.hidden = true
        self.btnPlayers.hidden = true
    }
}
