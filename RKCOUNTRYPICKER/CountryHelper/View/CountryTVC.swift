//
//  CountryTVC.swift
//  CountryPicker
//
//  Created by Techugo on 20/07/21.
//

import UIKit

class CountryTVC: UITableViewCell {

    @IBOutlet weak var dialCodeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    static let identifier: String = "CountryTVC"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with obj: CountryPickerModelElement) {
        let space: String = " "
        nameLbl.text = obj.flag + space + obj.name + space + "(" + obj.code + ")"
        dialCodeLbl.text = "+\(obj.dialCode)"
    }
}

extension CountryTVC {
    class func getNib() -> UINib {
        return UINib(nibName: CountryTVC.identifier, bundle: nil)
    }
}

