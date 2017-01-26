//
//  ViewController.swift
//  What's The Weather
//
//  Created by Ebou Jobe on 2016-12-27.
//  Copyright © 2016 Ebou Jobe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    

    @IBAction func getWeather(_ sender: Any) {
        while (cityTextField.text?.contains("  "))!{
           cityTextField.text?.replacingOccurrences(of: " ", with: "-")
        }
        if let url = URL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
        let request  = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            var message = ""
            if error != nil {
                print(error)
            }
            else{
                if  let unrappingData = data {
                    let dataString = NSString(data: unrappingData, encoding: String.Encoding.utf8.rawValue)
                    var stringSeperator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                    dataString?.components(separatedBy: stringSeperator)
                    if let contentArray = dataString?.components(separatedBy: stringSeperator){
                        if contentArray.count > 1 {
                            stringSeperator = "</span>"
                            let newContentArray = contentArray[1].components(separatedBy: stringSeperator)
                            if newContentArray.count > 1 {
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                            }
                            
                        }
                    }
                }
            }
            if message == "" {
                message = "The weather couldn't be found"
            }
            DispatchQueue.main.sync {
                self.label.text = message
            }
        }
        task.resume()
        }
        else {
          label.text = "The weather couldn't be found"
        }
    }
    @IBOutlet var cityTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

