//
//  MAPD724 W2023
//  Group 9
//  Assignment 2
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
    
    private let winningCombinationsTableIdentifier = "WinningCombinationTable"
    private var winningCombinations = [WinningCombination]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let userInstructionsFile: URL! = Bundle.main.url(forResource: "user_instructions", withExtension: "txt")
            let userInstructions = try String(contentsOf: userInstructionsFile)
            userInstructionsTextView.text = userInstructions
        }
        catch {
            print("Fail to load help docs!")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return winningCombinations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

