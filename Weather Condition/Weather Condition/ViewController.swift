//
//  ViewController.swift
//  Weather Condition
//
//  Created by Srans022019 on 30/04/20.
//  Copyright © 2020 vikas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var displayWeatherLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func onTapSubmit(_ sender: Any) {
        
        weatherData()
    }
    
    func weatherData() {
        
        if let url = URL(string: "https://www.weather-forecast.com/locations/" + nameTF.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            var message = ""
            
            if error != nil {
                
                print(error!)
            }else {
                
                if let unwrappedData = data {
                    
                    let dataString = String(data: unwrappedData, encoding: .utf8)
                    
                    var stringSeperator = "b-forecast__table-description-content\"><span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeperator) {
                        
                        if contentArray.count > 1 {
                            
                            stringSeperator = "</span>"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeperator)
                            
                            if newContentArray.count > 1 {
                             
                                message = newContentArray[0]
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
            if message == "" {
                message = "The weather there counld'nt be found. Please try later"
            }
            
            DispatchQueue.main.async {
                self.displayWeatherLbl.text = message
            }
            
        }
            task.resume()
            
        }else {
            displayWeatherLbl.text = "Enter correct name"
        }
    }
    
}

