//
//  MAPD724 W2023
//  Group 9
//  Assignment 2
//  App description: slot machine
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  WinningCombinationsTableViewCell.swift
//  Date: Feb 17, 2023
//  Version: 3.0
//

import UIKit

// The table view cell to display winning combination
class WinningCombinationsTableViewCell: UITableViewCell {

    public static let identifier = "WinningCombinationsTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WinningCombinationsTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // configure the content of UIs of the cell
    func configure(winningCombination: WinningCombination, row: Int) {
        
    }
}