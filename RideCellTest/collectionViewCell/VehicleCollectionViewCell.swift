//
//  VehicleCollectionViewCell.swift
//  RideCellTest
//
//  Created by Apple on 17/07/22.
//

import UIKit

class VehicleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vehicleReserveCarBtn: UIButton!
    @IBOutlet weak var vehicleSpeed: UILabel!
    @IBOutlet weak var remainingMilege: UILabel!
    @IBOutlet weak var vehicleName: UILabel!
    @IBOutlet weak var vehicleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
          super.prepareForReuse()
          self.vehicleImageView.image = nil
      }

}
