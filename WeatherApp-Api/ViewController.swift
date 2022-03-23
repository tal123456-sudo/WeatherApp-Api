//
//  ViewController.swift
//  WeatherApp-Api
//
//  Created by Talha Varol on 24.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var feelsLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var howCloudLabel: UILabel!
    let api = "f86ae7418a8d89538ab6ab0f1d600572"
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // 1. step Web services
    // 2. Json al Data yap
    // 3. Datayı göster


    @IBAction func getWhaterButton(_ sender: Any) {
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=40.880818&lon=29.256590&appid=\(api)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil{
                print("error")
            }else{
                // 2. adım datayı aldık
                if data != nil{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any]
                        
                        DispatchQueue.main.async {
                            if let main = jsonResponse!["main"] as? [String : Any]{
                                if let temp = main["temp"] as? Double{
                                    self.currentTemp.text = String(Int(temp - 272.15))
                                }
                                if let feels = main["feels_like"] as? Double{
                                    self.feelsLabel.text = String(Int(feels - 272.15))
                                }
                            }
                            if let wind = jsonResponse!["wind"] as? [String : Any]{
                                if let speed = wind["speed"] as? Double{
                                    self.windLabel.text = String(Int(speed))
                                }
                            }
                            if let city = jsonResponse!["name"] as? String{
                                self.cityLabel.text = String("🇹🇷 \(city) 🇹🇷")
                            }
                            if let cloud = jsonResponse!["clouds"] as? [String : Any]{
                                if let allCloud = cloud["all"] as? Int{
                                    self.howCloudLabel.text = String("%\(allCloud)")
                                }
                            }
                        }
                    }catch{
                        
                    }
                }
            }
        
        }
        task.resume()
    }
}

