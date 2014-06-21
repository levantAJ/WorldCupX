//
//  MatchTableViewCell.swift
//  WorldCupX
//
//  Created by AJ on 6/19/14.
//  Copyright (c) 2014 ATteam. All rights reserved.
//

import UIKit

class PlayerTableViewCell : UITableViewCell{
    @IBOutlet var lblName: UILabel
    @IBOutlet var lblDetails: UILabel
    @IBOutlet var imgAvatar: UIImageView
    @IBOutlet var btnStatus: UIButton
    
    @IBOutlet var lblNickname: UILabel
    @IBOutlet var lblNationality: UILabel
    @IBOutlet var lblBirthday: UILabel
    @IBOutlet var lblGoals: UILabel
    @IBOutlet var lblBody: UILabel
    
    func showDetails(){
        self.lblBirthday.hidden = false
        self.lblBody.hidden = false
        self.lblGoals.hidden = false
        self.lblNationality.hidden = false
        self.lblNickname.hidden = false
    }
    
    func hideDetails(){
        self.lblBirthday.hidden = true
        self.lblBody.hidden = true
        self.lblGoals.hidden = true
        self.lblNationality.hidden = true
        self.lblNickname.hidden = true
    }
}
