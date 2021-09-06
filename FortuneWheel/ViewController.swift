//
//  ViewController.swift
//  FortuneWheel
//
//  Created by Faraz Haider on 31/08/2021.
//

import UIKit
import SwiftFortuneWheel

class ViewController: UIViewController {
    
    var selectedIndex = -1
    
    
    @IBOutlet weak var wheelControl: SwiftFortuneWheel!
    
    var prizes = [(id:0,name: "MONEYMONEY", color: #colorLiteral(red: 0.9607843137, green: 0.768627451, blue: 0.568627451, alpha: 1),winningColor: #colorLiteral(red: 0.9333333333, green: 0.6078431373, blue: 0.2705882353, alpha: 1),losingColor: #colorLiteral(red: 0.737254902, green: 0.2901960784, blue: 0.6156862745, alpha: 1), textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
                  (id:1,name: "GRAPHIC", color: #colorLiteral(red: 0.9843137255, green: 0.9098039216, blue: 0.8274509804, alpha: 1),winningColor: #colorLiteral(red: 0.9607843137, green: 0.768627451, blue: 0.568627451, alpha: 1), losingColor: #colorLiteral(red: 0.737254902, green: 0.2901960784, blue: 0.6156862745, alpha: 1),textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                  (id:2,name: "HOME", color: #colorLiteral(red: 0.9607843137, green: 0.768627451, blue: 0.568627451, alpha: 1),winningColor: #colorLiteral(red: 0.9333333333, green: 0.6078431373, blue: 0.2705882353, alpha: 1),losingColor: #colorLiteral(red: 0.737254902, green: 0.2901960784, blue: 0.6156862745, alpha: 1), textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
                  (id:3,name: "IDEA", color: #colorLiteral(red: 0.9843137255, green: 0.9098039216, blue: 0.8274509804, alpha: 1), winningColor: #colorLiteral(red: 0.9333333333, green: 0.6078431373, blue: 0.2705882353, alpha: 1), losingColor: #colorLiteral(red: 0.737254902, green: 0.2901960784, blue: 0.6156862745, alpha: 1),textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
                  (id:4,name: "MANAGMENT", color: #colorLiteral(red: 0.9607843137, green: 0.768627451, blue: 0.568627451, alpha: 1),winningColor: #colorLiteral(red: 0.9333333333, green: 0.6078431373, blue: 0.2705882353, alpha: 1), losingColor: #colorLiteral(red: 0.737254902, green: 0.2901960784, blue: 0.6156862745, alpha: 1),textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                  (id:5,name: "SEARCH", color: #colorLiteral(red: 0.9843137255, green: 0.9098039216, blue: 0.8274509804, alpha: 1),winningColor: #colorLiteral(red: 0.9333333333, green: 0.6078431373, blue: 0.2705882353, alpha: 1),  losingColor: #colorLiteral(red: 0.737254902, green: 0.2901960784, blue: 0.6156862745, alpha: 1),textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                  (id:6,name: "TARGET", color: #colorLiteral(red: 0.9607843137, green: 0.768627451, blue: 0.568627451, alpha: 1),winningColor: #colorLiteral(red: 0.9333333333, green: 0.6078431373, blue: 0.2705882353, alpha: 1),  losingColor: #colorLiteral(red: 0.737254902, green: 0.2901960784, blue: 0.6156862745, alpha: 1),textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                  (id:7,name: "TIME", color: #colorLiteral(red: 0.9843137255, green: 0.9098039216, blue: 0.8274509804, alpha: 1),winningColor: #colorLiteral(red: 0.9333333333, green: 0.6078431373, blue: 0.2705882353, alpha: 1), losingColor: #colorLiteral(red: 0.737254902, green: 0.2901960784, blue: 0.6156862745, alpha: 1),textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]

    
    
    var slices = [Slice] ()

    var finishIndex: Int {
        return Int.random(in: 0..<wheelControl.slices.count)
    }

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wheelControl.configuration = .variousWheelPodiumConfiguration
        wheelControl.spinImage = "center"
        wheelControl.isSpinEnabled = false
        updateSlice()
        self.wheelControl.slices = self.slices
        
        
    }
    
    @IBAction func rotateTap(_ sender: Any) {
        let finishingIndex = self.finishIndex
           print(finishingIndex)
           wheelControl.startRotationAnimation(finishIndex: finishingIndex, continuousRotationTime: 1) { (isFinished) in
               guard isFinished else { return }
               print(self.prizes[finishingIndex])
               self.selectedIndex = finishingIndex
               self.updateSlice()
               self.wheelControl.slices = self.slices
               
               // set rotation async on main queue
               DispatchQueue.main.async {
                   self.wheelControl.rotate(toIndex: finishingIndex)
               }
           }
             
//            for (index,slice) in self.wheelControl.slices.enumerated(){
//                var slicing = slice
//                if index == finishingIndex{
//                    slicing.backgroundColor = UIColor.red
//                }else{
//                    slicing.backgroundColor = UIColor.yellow
//                }
//
//                self.wheelControl.slices[index] = slicing
//            }
            
//            self.wheelControl.slices = self.slices
//            self.wheelControl.rotate(toIndex: finishingIndex)
//        }
    }
    
    func updateSlice(){
        slices = []
        for (index,prize) in prizes.enumerated() {
            print(index,prize.name)
            
            var titleTextPreferences = TextPreferences(textColorType: .customPatternColors(colors: nil, defaultColor: .black), font: .systemFont(ofSize: 10, weight: .bold), verticalOffset: 20)
                titleTextPreferences.horizontalOffset = 10
                titleTextPreferences.orientation = .vertical
                titleTextPreferences.spacing = 0
                titleTextPreferences.alignment = .left
                
            var descriptionTextPreferences = TextPreferences(textColorType: .customPatternColors(colors: nil, defaultColor: .red), font: .systemFont(ofSize: 10), verticalOffset:-75)

            descriptionTextPreferences.horizontalOffset = 0
            descriptionTextPreferences.orientation = .vertical
            descriptionTextPreferences.spacing = 0
            descriptionTextPreferences.alignment = .left

            let content: [Slice.ContentType] = [.text(text: prize.name, preferences: titleTextPreferences),.text(text: prize.name, preferences: descriptionTextPreferences)]
   
            var slice = Slice(contents: content)
            if selectedIndex == -1{
                slice.backgroundColor = prize.color
            }else{
                slice.backgroundColor = index == selectedIndex ? prize.winningColor : prize.losingColor
            }
            slices.append(slice)
        }
       
    }

}


public extension SFWConfiguration {
    static var variousWheelPodiumConfiguration: SFWConfiguration {
        
        let spin = SFWConfiguration.SpinButtonPreferences(size: CGSize(width: 64, height: 64))
        
        let sliceBackgroundColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .gray, oddColor: .darkGray)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceBackgroundColorType,
                                                                            strokeWidth: 0,
                                                                            strokeColor: .clear)
        
//
//        let anchorImage = SFWConfiguration.AnchorImage(imageName: "anchorImage", size: CGSize(width: 8, height: 8), verticalOffset: -10)
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: 1, strokeColor: UIColor.init(red: 32/255, green: 93/255, blue: 97/255, alpha: 1))
        
        var wheelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences,
                                                                 slicePreferences: slicePreferences,
                                                                 startPosition: .right)
        
//        wheelPreferences.imageAnchor = anchorImage

        let configuration = SFWConfiguration(wheelPreferences: wheelPreferences, spinButtonPreferences: spin)

        return configuration
    }
}

public extension TextPreferences {
    static func variousWheelPodiumText(textColor: UIColor) -> TextPreferences {

        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: textColor)
        
        var font = UIFont.systemFont(ofSize: 9, weight: .semibold)
        var horizontalOffset: CGFloat = 0
        
        if let customFont = UIFont(name: "DINCondensed-Bold", size: 12) {
            font = customFont
            horizontalOffset = -2
        }
    
        var textPreferences = TextPreferences(textColorType: textColorType,
                                                 font: font,
                                                 verticalOffset: 5)
        
        textPreferences.horizontalOffset = horizontalOffset
        textPreferences.orientation = .vertical
        textPreferences.alignment = .right
        
        return textPreferences
    }
}

public extension ImagePreferences {
    static var variousWheelPodiumImage: ImagePreferences {
        let imagePreferences = ImagePreferences(preferredSize: CGSize(width: 25, height: 25), verticalOffset: 5)
        return imagePreferences
    }
}
