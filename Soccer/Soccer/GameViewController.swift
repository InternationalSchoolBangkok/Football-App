//
//  GameViewController.swift
//  Soccer
//
//  Created by Pearl on 4/3/2560 BE.
//  Copyright © 2560 Pearl. All rights reserved.
//

import UIKit
//import CoreData

class GameViewController: UIViewController {
    
    //
    var selectedPlayer:Player?
    var playerArray = Player.sharedInstance
    var counter:Int = 0
    var playerSelected:Bool = false
    var commandSelected:Bool = false
    var positionSelected:Bool = false
    var buttonsArray:[UIButton] = []
    var location:CGPoint?
    
//    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    let managedContext:NSManagedObjectContext = appDelegate.managedObjectContext
//    var playerObjects = [NSManagedObject]()
    
    
    //ALl linked UI elements
    var controlsView:UIView!
    var teamView:UIView!
    var tableView:UITableView!
    var field:UIImageView!
    var passLabel:UILabel!
    var passY:UIButton!
    var passN:UIButton!
    var appendButton:UIButton!
    
    func initialize() {
        var test:TestClass = TestClass()
        playerArray.append(test.A)
        playerArray.append(test.B)
        playerArray.append(test.C)
    }
    
    let screen:CGRect = UIScreen.mainScreen().bounds
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
        var nav = self.navigationController?.navigationBar
        var margin = (nav?.frame.maxY)!
        
        //Only edit these values to change appearance
        var horizontal  = screen.height*7/10
        var vertical = screen.width/4
        //

        controlsView = UIView(frame: CGRectMake(0, horizontal, screen.width, screen.height-horizontal))
        teamView = UIView(frame: CGRectMake(0, margin, vertical, controlsView.frame.origin.y - margin))
        tableView = UITableView(frame: CGRectMake(20, teamView.frame.origin.y+20, teamView.frame.width-40, teamView.frame.height-40))
        field = UIImageView(frame: CGRectMake(teamView.frame.maxX, margin, screen.width-teamView.frame.maxX, controlsView.frame.origin.y-margin))
        
        
        controlsView.backgroundColor = UIColor.blackColor()
        teamView.backgroundColor = UIColor.greenColor()
        field.image = UIImage(named:"field")
        field.contentMode = .ScaleToFill
        
        tableView.registerClass(PlayerTVC.self, forCellReuseIdentifier: "cell")
        tableView.scrollEnabled = false
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
 
        view.addSubview(controlsView)
        view.addSubview(teamView)
        view.addSubview(tableView)
        view.addSubview(field)
        
        
        let boxHeight = (controlsView.frame.height - 15)/2
        let boxLength = (controlsView.frame.width - 30 - vertical)/3
        
        passLabel = UILabel(frame: CGRectMake(vertical+10, 5, boxLength, boxHeight/3))
        passLabel.backgroundColor = UIColor.grayColor()
        passLabel.text = "Pass"
        passY = UIButton(frame: CGRectMake(passLabel.frame.origin.x, passLabel.frame.maxY, boxLength/2, boxHeight*2/3))
        passY.backgroundColor = UIColor.blueColor()
        passY.setTitle("Yes", forState: .Normal)
        
        passN = UIButton(frame: CGRectMake(passY.frame.maxX, passLabel.frame.maxY, boxLength/2, boxHeight*2/3))
        passN.backgroundColor = UIColor.redColor()
        passN.setTitle("No", forState: .Normal)
        
        appendButton = UIButton(frame: CGRectMake(0,0,5,5))
        appendButton.addTarget(self, action: #selector(self.newData), forControlEvents: .TouchUpInside)
        
        
        buttonsArray.append(passY)
        buttonsArray.append(passN)
        
        for button in buttonsArray {
            button.addTarget(self, action: #selector(self.buttonClicked), forControlEvents: .TouchUpInside)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        field.userInteractionEnabled = true
        field.addGestureRecognizer(tapGestureRecognizer)
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.imagePanned))
//        field.addGestureRecognizer(panGestureRecognizer)
        
        controlsView.addSubview(passLabel)
        controlsView.addSubview(passY)
        controlsView.addSubview(passN)
        controlsView.addSubview(appendButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if positionSelected == false {
            
            positionSelected = true
            counter = counter + 1
            
        } else {
            for layer in field.layer.sublayers! {
                layer.removeFromSuperlayer()
            }
        }
        
        //Create dot there
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        var position:CGPoint = tapGestureRecognizer.locationInView(tappedImage)
        
        let shapeLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: position.x,y: position.y), radius: CGFloat(7), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        shapeLayer.path = circlePath.CGPath
        //change the fill color
        shapeLayer.fillColor = UIColor.blueColor().CGColor
        //change the stroke color
        shapeLayer.strokeColor = UIColor.blueColor().CGColor
        field.layer.addSublayer(shapeLayer)
    }
    
//    func imagePanned(panGestureRecognizer: UIPanGestureRecognizer) {
//        
//        let tappedImage = panGestureRecognizer.view as! UIImageView
//        var position:CGPoint = panGestureRecognizer.translationInView(tappedImage)
//        
//        let ctx = UIGraphicsGetCurrentContext()
//        //2
//        CGContextBeginPath(ctx)
//        CGContextMoveToPoint(ctx, position.x, position.y)
//        CGContextAddLineToPoint(ctx, position.x, position.y)
//        
//        //3
//        CGContextClosePath(ctx)
//        CGContextStrokePath(ctx)
//    }
    
    func buttonClicked(button: UIButton) {
        //If it hasn't been clicked yet
        if button.selected == false {
            self.isSelected(button)
            commandSelected = true
            counter = counter + 1
            if counter == 3 {
                //perform selector
                appendButton.sendActionsForControlEvents(.TouchUpInside)
            }
            for B in buttonsArray {
                if button.titleLabel?.text == B.titleLabel?.text {
                    //they are the same button
                    //do nothing
                } else {
                    //deselect it
                    if B.selected == true {
                        self.isDeSelected(B)
                    }
                }
            }
        } else {
            self.isDeSelected(button)
            button.selected = false
            commandSelected = false
            counter = counter - 1
        }
    }
    
    func isSelected(button:UIButton) {
        button.alpha = 0.5
        button.selected = true
        print("selected")
    }
    
    func isDeSelected(button:UIButton) {
        button.alpha = 1
        button.selected=false
        print("deselected")
    }
    
    func newData() {
    //Store the data point to the respective player
        //Convert player objects in array to NSData
        //
    }

}

extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.bounds.height/4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if playerArray.count < 4 {
            return playerArray.count
        } else {
            return 4
        }
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PlayerTVC
        
        //NOT NECESSARILY DONT FORGET TO CHANGE TO ACCOUNT FOR CHOSEN PLAYERS
        cell.player = playerArray[indexPath.row]
     
        cell.backgroundColor = UIColor.clearColor()
        
        cell.iconImage = UIImageView(frame: CGRectMake(cell.bounds.origin.x, cell.bounds.origin.y, cell.bounds.width/2, cell.bounds.height - 20))
        cell.iconImage.image = UIImage(named: "jersey")
        
        cell.nameLabel = UILabel(frame: CGRectMake(cell.iconImage.bounds.maxX, cell.bounds.origin.y+5, cell.bounds.maxX-cell.iconImage.bounds.maxX, cell.bounds.maxY-cell.bounds.origin.y-5))
        
        if let player = cell.player {
            cell.nameLabel.text = player.name
        } else {
            //no name present
        }
        
        cell.contentView.addSubview(cell.iconImage)
        cell.contentView.addSubview(cell.nameLabel)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell:PlayerTVC = tableView.cellForRowAtIndexPath(indexPath) as! PlayerTVC
        self.selectedPlayer = cell.getPlayer()
        if playerSelected == false {
            counter = counter + 1
            playerSelected = true
        }
    }
    
}
