//
//  MAPD724 W2023
//  Group 9
//  Assignment 3
//  App description: slot machine
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  HelpPageViewController.swift
//  Date: Feb 17, 2023
//  Version: 3.0
//

import UIKit

class HelpPageViewController:
    UIViewController,
    UITableViewDataSource,
    UITableViewDelegate
{

    @IBOutlet weak var userInstructionsTextView: UITextView!
    @IBOutlet weak var winningCombinationsTableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    
    private var winningCombinations = [WinningCombination]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a gradient layer.
                let gradientLayer = CAGradientLayer()
                gradientLayer.frame = view.bounds
                gradientLayer.colors = [#colorLiteral(red: 0.1705927849, green: 0.2532435358, blue: 0.3451030254, alpha: 1).cgColor, #colorLiteral(red: 0.9186434746, green: 0.3272016048, blue: 0.3362314999, alpha: 1).cgColor, #colorLiteral(red: 0.1759031415, green: 0.2531238198, blue: 0.3492524326, alpha: 1).cgColor]
                gradientLayer.shouldRasterize = true
                backgroundView.layer.addSublayer(gradientLayer)
        
        //style for tableview cell
        winningCombinationsTableView.rowHeight = 70.0
        winningCombinationsTableView.layer.borderWidth = 4
        winningCombinationsTableView.layer.borderColor = UIColor.white.cgColor
        
        //color
        let blue = UIColor(red: 45/255, green: 64/255, blue: 89/255, alpha: 1.0)
        let red = UIColor(red: 234/255, green: 84/255, blue: 85/255, alpha: 0.8)
        
        
        do {
            // load the content of the user instructions from resource
            let userInstructionsFile: URL! = Bundle.main.url(forResource: "user_instructions", withExtension: "txt")
            let userInstructions = try String(contentsOf: userInstructionsFile)
            userInstructionsTextView.text = userInstructions
            userInstructionsTextView.textColor = blue
            userInstructionsTextView.backgroundColor = UIColor.systemGray5
            userInstructionsTextView.layer.borderWidth = 4
            userInstructionsTextView.layer.borderColor = UIColor.white.cgColor
            
            
            
            // configure the winning combinations table view
            initWinningCombinations()
            winningCombinationsTableView.register(WinningCombinationsTableViewCell.nib(), forCellReuseIdentifier: WinningCombinationsTableViewCell.identifier)
        }
        catch {
            print("Fail to load help docs!")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return winningCombinations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // configure the UI of the table view cell of a winning combination
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WinningCombinationsTableViewCell.identifier,
            for: indexPath
        ) as! WinningCombinationsTableViewCell
        cell.configure(
            winningCombination: winningCombinations[indexPath.row],
            row: indexPath.row
        )
        
        return cell
    }
    
    // add the winning combinations into the list
    private func initWinningCombinations() {
        winningCombinations.append(WinningCombination(symbolImageName: "1", numOfSymbol: 0, payoutRatio: 0))
        winningCombinations.append(WinningCombination(symbolImageName: "9", numOfSymbol: 3, payoutRatio: 100))
        winningCombinations.append(WinningCombination(symbolImageName: "8", numOfSymbol: 3, payoutRatio: 75))
        winningCombinations.append(WinningCombination(symbolImageName: "7", numOfSymbol: 3, payoutRatio: 50))
        winningCombinations.append(WinningCombination(symbolImageName: "6", numOfSymbol: 3, payoutRatio: 40))
        winningCombinations.append(WinningCombination(symbolImageName: "5", numOfSymbol: 3, payoutRatio: 30))
        winningCombinations.append(WinningCombination(symbolImageName: "4", numOfSymbol: 3, payoutRatio: 20))
        winningCombinations.append(WinningCombination(symbolImageName: "3", numOfSymbol: 3, payoutRatio: 10))
        winningCombinations.append(WinningCombination(symbolImageName: "2", numOfSymbol: 3, payoutRatio: 5))
        winningCombinations.append(WinningCombination(symbolImageName: "9", numOfSymbol: 2, payoutRatio: 20))
        winningCombinations.append(WinningCombination(symbolImageName: "8", numOfSymbol: 2, payoutRatio: 10))
        winningCombinations.append(WinningCombination(symbolImageName: "7", numOfSymbol: 2, payoutRatio: 5))
        winningCombinations.append(WinningCombination(symbolImageName: "6", numOfSymbol: 2, payoutRatio: 4))
        winningCombinations.append(WinningCombination(symbolImageName: "5", numOfSymbol: 2, payoutRatio: 3))
        winningCombinations.append(WinningCombination(symbolImageName: "4", numOfSymbol: 2, payoutRatio: 2))
        winningCombinations.append(WinningCombination(symbolImageName: "3", numOfSymbol: 2, payoutRatio: 2))
        winningCombinations.append(WinningCombination(symbolImageName: "2", numOfSymbol: 2, payoutRatio: 2))
        winningCombinations.append(WinningCombination(symbolImageName: "9", numOfSymbol: 1, payoutRatio: 5))
        winningCombinations.append(WinningCombination(symbolImageName: "8", numOfSymbol: 1, payoutRatio: 1))
        winningCombinations.append(WinningCombination(symbolImageName: "7", numOfSymbol: 1, payoutRatio: 1))
        winningCombinations.append(WinningCombination(symbolImageName: "6", numOfSymbol: 1, payoutRatio: 1))
        winningCombinations.append(WinningCombination(symbolImageName: "5", numOfSymbol: 1, payoutRatio: 1))
        winningCombinations.append(WinningCombination(symbolImageName: "4", numOfSymbol: 1, payoutRatio: 1))
        winningCombinations.append(WinningCombination(symbolImageName: "3", numOfSymbol: 1, payoutRatio: 1))
        winningCombinations.append(WinningCombination(symbolImageName: "2", numOfSymbol: 1, payoutRatio: 1))
    }
    
}

