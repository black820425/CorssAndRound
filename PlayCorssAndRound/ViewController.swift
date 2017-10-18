//
//  ViewController.swift
//  PlayCorssAndRound
//
//  Created by 黃柏恩 on 2017/6/11.
//  Copyright © 2017年 黃柏恩. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var Box: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    var Player = 1
    var gameState = [0,0,0,0,0,0,0,0,0]
    var winWay = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var imagename = ["Giraffe1.png","Giraffe2.png","Giraffe3.png"]
    var value = 1
    var State = true
    var State2 = true
    var time:Timer?

//
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //設定透明度
        label.alpha = 0.5
        Box.alpha = 0.9
        PlayAgainButton.alpha = 0.9
       
        
        //放入照片
        imageView.image = UIImage(named:"Giraffe1.png")
        //加入時間
        time = Timer.scheduledTimer(timeInterval: 10, target: self, selector:#selector(changeImage), userInfo: nil, repeats: true)
        
        
    }
//
    override func viewDidDisappear(_ animated: Bool)
    {
        if time != nil
        {
            time?.invalidate()
            time = nil
        }
    }
//
    //改變照片
    func changeImage()
    {
        animated()
        imageView.image = UIImage(named:imagename[value]);
        value += 1
        if value > 2
        {
            value = 0
        }
        
    }
//
    @IBAction func action(_ sender: Any)
    {
       if(gameState[(sender as AnyObject).tag-1] == 0 && State == true && State2 == true) {
            gameState[(sender as AnyObject).tag-1] = Player
            
            if(Player == 1){
                //        sender.setImage(UIImage(named: "corss.png"),forState:UIControlState)
                (sender as AnyObject).setImage(UIImage(named:"corss.png"), for: UIControlState.normal)
                Player = 2
            }
            else {
                (sender as AnyObject).setImage(UIImage(named: "round.png"),for:UIControlState.normal)
                Player = 1
            }
        }
        
        for win in winWay
        {
            if(gameState[win[0]] != 0 && gameState[win[0]] == gameState[win[1]] && gameState[win[1]] == gameState[win[2]]) {
                State = false;
                
                if(gameState[win[0]] == 1) {
                    label.text = "叉叉贏了！"
                    State = false
                    State2 = false
                }
                else {
                    label.text = "圈圈贏了！"
                    State = false
                    State2 = false
                }
                PlayAgainButton.isHidden = false
                label.isHidden = false
            }
        }
        State = false
        
        for i in gameState {
            if i == 0 {
                State = true
                break
            }
        }
        if(State == false && State2 == true) {
            label.text = "真可惜 平手了！"
            PlayAgainButton.isHidden = false
            label.isHidden = false
        }
    }
//
    @IBOutlet weak var PlayAgainButton: UIButton!
    @IBAction func PlayAgain(_ sender: Any) {
        gameState = [0,0,0,0,0,0,0,0,0]
        State = true
        State2 = true
        Player = 1
        
        for i in 1...9
        {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControlState())
        }
        
        PlayAgainButton.isHidden = true
        label.isHidden = true
        
    }
//
    //建立動畫效果
    func animated()
    {
     let transistion = CATransition()
     transistion.duration = 0.5
        transistion.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
     transistion.type = kCATransitionFade
     //transistion.subtype =
     //transistion.subtype = subType
     imageView.layer.add(transistion, forKey: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

