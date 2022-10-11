//
//  CountryPickerVM.swift
//  CountryPicker
//
//  Created by Techugo on 20/07/21.
//

import Foundation
class CountryPickerVM {
    var arrCountries: CountryPickerModel = []
    var arrTempCountries: CountryPickerModel = []
    
    init() {
        loadCountryDataFromJson()
    }
    
    
    func loadCountryDataFromJson()  {
        guard let path = Bundle.main.path(forResource: "countries", ofType: "json") else {
          fatalError("countries.json file is missing")
        }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let fetchedList = try! JSONDecoder().decode(CountryPickerModel.self, from: data)
        arrCountries = fetchedList
        arrTempCountries = arrCountries
    }
    
    
    
    func getCountryFlag(from selectedCountryCode: String ) -> String {
        guard let path = Bundle.main.path(forResource: "countries", ofType: "json") else {
          fatalError("countries.json file is missing")
        }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let fetchedList = try! JSONDecoder().decode(CountryPickerModel.self, from: data)
        let countryCodeWithoutPlus = selectedCountryCode.contains("+") ? String(selectedCountryCode.dropFirst()) : selectedCountryCode
        let searchResult = fetchedList.filter {("\($0.dialCode)" == countryCodeWithoutPlus) }
        return searchResult.count > 0 ? searchResult[0].flag : ""
    }
    
}


