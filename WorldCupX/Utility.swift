//
//  Utility.swift
//  WorldCupX
//
//  Created by AJ on 6/16/14.
//  Copyright (c) 2014 ATteam. All rights reserved.
//

import Foundation

class Utility{
    
    var key: String?
    var value: String?
    
    init(){}
    
    init(key: String, value: String){
        self.key = key
        self.value = value
    }
    
    class func getImage(url: String) -> UIImage{
        var imageURL = NSURL(string: url)
        var imageData: NSData = NSData(contentsOfURL: imageURL)
        return UIImage(data: imageData)
    }
    
    class func getImage(url: String, newSize: CGSize) -> UIImage{
        var image = self.getImage(url)
        return self.imageWithImage(image, newSize: newSize)
    }
    
    class func imageWithImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        return newImage;
    }
    
    class func convertDateToString(date: NSDate) -> String{
        var formatter: NSDateFormatter = NSDateFormatter()
        // EEE MMM dd, YYYY HH:mm
        formatter.dateFormat = "YYYY-MM-ddThh:mm:ss.zzz"
        return formatter.stringFromDate(date)
    }
    
    class func convertDateToString(date: NSDate, format: String) -> String{
        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(date)
        
    }
    
    class func convertStringToDate(dateString: String) -> NSDate{
        var result: NSDate = NSDate()
        var data: String[] = dateString.componentsSeparatedByString("T")
        if data.count>1{
            var date: String[] = data[0].componentsSeparatedByString("-")
            var time: String[] = data[1].componentsSeparatedByString(":")
            if date.count>2 && time.count>2{
                var comp: NSDateComponents = NSDateComponents()
                comp.year = date[0].toInt()!
                comp.month = date[1].toInt()!
                comp.day = date[2].toInt()!
                comp.hour = time[0].toInt()!
                comp.minute = time[1].toInt()!
                
                var gregorian = NSCalendar(identifier: NSGregorianCalendar)
                result = gregorian.dateFromComponents(comp)
            }
        }
        return result
        //        var formatter: NSDateFormatter = NSDateFormatter()
        //        var timezone: NSTimeZone = NSTimeZone(name: "UTC")
        //        formatter.timeZone = timezone
        //        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //        return formatter.dateFromString(dateString)
    }
    
    class func getCodeByCode(code: String) -> String{
        var str: String = ""
        for c in code.utf8{
            str += "\(c)"
        }
        if str.compare("99195180116")==0{
            return "civ"
        }
        
        switch code{
        case "net":
            return "ned"
        case "spa":
            return "esp"
        case "cam":
            return "cmr"
        case "cos":
            return "crc"
        case "jap":
            return "jpn"
        case "swi":
            return "sui"
        case "bos":
            return "bih"
        case "ira":
            return "irn"
        case "uni":
            return "usa"
        default:
            return code
        }
    }
    
    class func selectedCell() -> UIView{
        var bgColorView = UIView()
        bgColorView.backgroundColor = self.pinkColor()
        return bgColorView
    }
    
    class func greenColor() -> UIColor{
        return UIColor(red: 158/255.0, green: 211/255.0, blue: 15/255.0, alpha: 1)
    }
    class func borderColor() -> UIColor{
        return UIColor(red: 212.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1)
    }
    class func orangeColor() -> UIColor{
        return UIColor(red: 255/255.0, green: 167/255.0, blue: 28/255.0, alpha: 1)
    }
    class func blueColor() -> UIColor{
        return UIColor(red: 100/255.0, green: 194/255.0, blue: 227/255.0, alpha: 1)
    }
    class func pinkColor() -> UIColor{
        return UIColor(red: 206/255, green: 67/255, blue: 130/255, alpha: 1)
    }
    class func purpleColor() -> UIColor{
        return UIColor(red: 124/255, green: 118/255, blue: 247/255, alpha: 1)
    }
}