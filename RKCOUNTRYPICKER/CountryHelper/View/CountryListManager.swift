//
//  CountryListManager.swift
//  CountryPicker
//
//  Created by Techugo on 20/07/21.
//

import UIKit
protocol CountryListManagerDelegate {
    func getCountryCode(country: CountryPickerModelElement)
}

class CountryListManager: UIViewController {
   
    @IBOutlet weak var countryTbl: UITableView!
    @IBOutlet weak var searchBarText: UITextField!
    @IBOutlet weak var headingLbl: UILabel!
    
    private let viewModel = CountryPickerVM()
    var delegate: CountryListManagerDelegate?
    var headingTitle: String?
    var noDataAvailableTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headingLbl.text = headingTitle ?? ""
        countryTbl.register(CountryTVC.getNib(), forCellReuseIdentifier: CountryTVC.identifier)
        searchBarText.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    convenience init() {
        self.init(headingTitle: "Select a country", noDataAvailableTitle: "No data available")
    }
    
    init(headingTitle: String, noDataAvailableTitle: String) {
        self.headingTitle = headingTitle
        self.noDataAvailableTitle = noDataAvailableTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func implementSearch(searchString: String) {
        if searchString.isEmpty {
            viewModel.arrCountries = viewModel.arrTempCountries
            self.countryTbl.reloadData()
            return
        }
        let searchResult = viewModel.arrTempCountries.filter { ($0.name.lowercased().contains(searchString.lowercased()))}
        if searchResult.isEmpty {
            viewModel.arrCountries = []
        }else {
            viewModel.arrCountries = searchResult
        }
        self.countryTbl.reloadData()
    }
   

}

//MARK:- UITableView Delegate And Datasource
extension CountryListManager : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if !viewModel.arrCountries.isEmpty {
            numOfSections            = 1
            tableView.backgroundView = nil
        }else{
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = noDataAvailableTitle ?? ""
            noDataLabel.textColor     = UIColor.darkGray
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTVC.identifier, for: indexPath) as! CountryTVC
        cell.configureCell(with: viewModel.arrCountries[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryData = viewModel.arrCountries[indexPath.row]
        dismiss(animated: true) {
            self.delegate?.getCountryCode(country: countryData)
        }
    }
}

// MARK: - UITextField Delegate
extension CountryListManager : UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.implementSearch(searchString: textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= 50
    }
    
}
