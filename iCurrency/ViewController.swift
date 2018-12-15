//
//  ViewController.swift
//  iCurrency
//
//  Created by Izabela Michalak on 15/12/2018.
//  Copyright © 2018 DeltaINKGames. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var myCurrency:[String] = []
    var myValues:[Double] = []
    
    var activeCurrency:Double = 0;
    
    //OBIEKTY
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var output: UILabel!
    
    //WYBÓR WALUTY
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return myCurrency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return myCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        activeCurrency = myValues[row]
        
    }
    
    //BUTTON
   
    @IBAction func action(_ sender: Any)
    {
        if (input.text != "")
        {
        output.text = String(Double(input.text!)! * activeCurrency)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //JSON
        let url=URL(string: "http://data.fixer.io/api/latest?access_key=4628d904effb21cc7f81826b8b94e5b6")
        
        let task = URLSession.shared.dataTask(with: url!){ (data,response,error) in
            if error != nil
            {
                print ("ERROR")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        let myJson=try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["rates"] as? NSDictionary
                        {
                            for(key, value) in rates
                            {
                                self.myCurrency.append((key as? String)!)
                                self.myValues.append((value as? Double)!)
                            }
                        }
                    }
                    catch
                    {
                        
                    }
                }
                
            }
            self.pickerView!.reloadAllComponents()
        }
        task.resume()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

