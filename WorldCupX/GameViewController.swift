//
//  FirstViewController.swift
//  WorldCupX
//
//  Created by AJ on 6/16/14.
//  Copyright (c) 2014 ATteam. All rights reserved.
//

import UIKit
import QuartzCore

class GameViewController: UIViewController {
    
    @IBOutlet var imgPepeFirst: UIImageView
    @IBOutlet var imgPepeSecond: UIImageView
    @IBOutlet var imgMillerFirst: UIImageView
    @IBOutlet var imgMillerSecond: UIImageView
    @IBOutlet var imgPow: UIImageView
    @IBOutlet var imgBubble: UIImageView
    @IBOutlet var lblTapToStart: UILabel
    @IBOutlet var lblPoints: UILabel
    @IBOutlet var lblTimer: UILabel
    @IBOutlet var lblPointed: UILabel
    @IBOutlet var viewParent: UIView
    @IBOutlet var viewGameOver: UIView
    @IBOutlet var lblTitle: UILabel
    @IBOutlet var btnNewGame: UIButton
    
    
    var start: Bool = false
    var points: Int = 0
    var timers: Int = 27
    var tmrTimer: NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.lblTapToStart.font = UIFont(name: "04b_19", size: 21)
//        self.lblPoints.font = UIFont(name: "04b_19", size: 31)
//        self.lblTimer.font = UIFont(name: "04b_19", size: 31)
//        self.lblTitle.font = UIFont(name: "04b_19", size: 21)
//        self.lblPointed.font = UIFont(name: "04b_19", size: 81)
//        self.btnNewGame.font = UIFont(name: "04b_19", size: 21)
        
        self.viewParent.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        self.viewGameOver.layer.borderColor = UIColor(red: 212.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1).CGColor
        self.viewGameOver.layer.borderWidth = 1
        self.viewGameOver.layer.cornerRadius = 7
        self.viewGameOver.layer.masksToBounds = true
        self.lblTitle.backgroundColor = UIColor(red: 134.0/255.0, green: 191.0/255.0, blue: 115.0/255.0, alpha: 1)
        //        var layer: CALayer = self.lblTitle.layer
        //        var bottomBorder: CALayer = CALayer(layer: layer)
        //        bottomBorder.borderColor = UIColor(red: 212.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1).CGColor
        //        bottomBorder.borderWidth = 0.5;
        //        bottomBorder.frame = CGRectMake(-1, layer.frame.size.height-1, layer.frame.size.width, 1);
        //        layer.addSublayer(bottomBorder)
        
        self.newGame()
    }
    
    func newGame(){
        self.start = false
        self.points = 0
        self.timers = 27
        self.lblTimer.text = "\(self.timers)"
        self.lblPoints.text = "0"
        self.lblTapToStart.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        if self.viewParent.hidden==true{
            if self.start==true{
                self.imgMillerFirst.hidden = true
                self.imgMillerSecond.hidden = false
                self.imgPepeFirst.hidden = true
                self.imgPepeSecond.hidden = false
                self.imgPow.hidden = false
                self.imgBubble.hidden = false
                self.points++
                self.lblPoints.text = "\(self.points)"
                NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "reheadbutt", userInfo: nil, repeats: false)
            }else{
                self.lblTapToStart.hidden = true
                self.start = true
                self.tmrTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countTimes", userInfo: nil, repeats: true)
            }
        }
    }
    
    func reheadbutt (){
        self.imgMillerFirst.hidden = false
        self.imgMillerSecond.hidden = true
        self.imgPepeFirst.hidden = false
        self.imgPepeSecond.hidden = true
        self.imgPow.hidden = true
        self.imgBubble.hidden = true
    }
    
    func countTimes(){
        self.timers--
        self.lblTimer.text = "\(self.timers)"
        
        if self.timers==0{
            self.tmrTimer.invalidate()
            self.start = false
            self.gameOver()
        }
    }
    
    func gameOver(){
        self.viewParent.hidden = false
        self.lblPointed.text = "\(self.points)"
    }
    
    @IBAction func newGamePressed(sender : AnyObject) {
        self.newGame()
        self.viewParent.hidden = true
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        
    }
}

