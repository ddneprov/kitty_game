//
//  ViewController.swift
//  useless_game
//
//  Created by Днепров Данила on 13/07/2019.
//  Copyright © 2019 Днепров Данила. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func StepperChanged(_ sender: UIStepper) {
        updateUI()
        //timeLabel.text = "Время: \(Int(sender.value)) сек"
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gameFieldView: UIView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var shapeX: NSLayoutConstraint!
    @IBOutlet weak var shapeY: NSLayoutConstraint!
    
    
    
    private var IsGameActive = false
    private var gameTimeLeft: TimeInterval = 0
    @IBOutlet weak var actionButton: UIButton!
    private var gameTimer: Timer?
    private var timer: Timer?
    private var displayDuration: TimeInterval = 2

    @IBAction func ActionButtonTapped(_ sender: UIButton) {
        if(IsGameActive){
            StopGame()
        }else{
            StartGame()
        }
    }
    

    
    private func StartGame(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: displayDuration, target: self, selector: #selector(moveImage), userInfo: nil, repeats: true)
        timer?.fire()
        
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameTimerTick), userInfo: nil, repeats: true)
        
        
        gameTimeLeft = stepper.value
        IsGameActive = true
        updateUI()
    }
    private func StopGame(){
        IsGameActive = false
        updateUI()
        gameTimer?.invalidate()
        timer?.invalidate()
    }
    
    
    private func updateUI(){
        stepper.isEnabled = !IsGameActive
        if IsGameActive{
            actionButton.setTitle("э, стой", for: .normal)
            timeLabel.text = "Осталось: \(Int(gameTimeLeft)) сек"
        }
        else{
            actionButton.setTitle("Погнали", for: .normal)
            timeLabel.text = "Время: \(Int(stepper.value)) сек"
        }
    }

    
    @objc private func gameTimerTick(){
        gameTimeLeft -= 1
        if gameTimeLeft <= 0{
            StopGame()
        }else { updateUI() }
    }
    
    
    
    @objc private func moveImage(){
        let maxX = 100
        let maxY = 100
        shapeX.constant = CGFloat(arc4random_uniform(UInt32(maxX)))
        shapeY.constant = CGFloat(arc4random_uniform(UInt32(maxY)))
    }



    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }


}
