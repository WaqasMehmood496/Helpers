//
//  MyRulerSlider.swift
//  rulerslider
//
//  Created by Macbook Pro on 12/01/2022.
//

import UIKit

class MyRulerSlider: UIView {

    var scrollView: UIScrollView!
    var label: UILabel!
    var value: Double! = 0
    var mid_ofset : CGFloat!
    
    let maxValue = 110.0
    let num_Lines = 45
    let lineSpacing = 25
    var halfSpace: CGFloat = 0.0
    
    let lines = UIBezierPath()
    
    override func draw(_ rect: CGRect) {
        scrollView = UIScrollView(frame: rect)
        configure()
        drawLines()
        configure2()
        initialScroll()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        halfSpace = CGFloat(CGFloat(lineSpacing) / 2.0)
        scrollView.backgroundColor = .black
    
        scrollView.contentSize = CGSize(width: (CGFloat((num_Lines - 1) * lineSpacing)) + self.frame.width, height: 100)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self
        
        mid_ofset = scrollView.contentSize.width/2
    }
    
    func drawLines(){
        
        var line_x : Double = Double(self.frame.width * 0.5)

        for temp in 1...Int(num_Lines) {
            
            var height : Double = 0
                let oneLine = UIBezierPath()
            
                if(temp % 2 == 0){
                    height = 20
                    oneLine.move(to: CGPoint(x: line_x, y: 60))
                }
                else{
                    height = 30
                    oneLine.move(to: CGPoint(x: line_x, y: 50))
                }
                
                oneLine.addLine(to: CGPoint(x: line_x, y: height))
                line_x = line_x + Double(lineSpacing)
                lines.append(oneLine)

        }
    }
    
    func configure2(){
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = lines.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1

        // ADD LINES IN LAYER
        scrollView.layer.addSublayer(shapeLayer)
        self.addSubview(scrollView)
        
        let midLine = UIBezierPath()
        midLine.move(to: CGPoint(x: self.frame.midX, y: 20))
        midLine.addLine(to: CGPoint(x: self.frame.midX, y: 50))
        
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = midLine.cgPath
        shapeLayer2.strokeColor = UIColor.yellow.cgColor
        shapeLayer2.lineWidth = 2
        
        self.layer.addSublayer(shapeLayer2)
        label = UILabel(frame: CGRect(x: self.frame.midX, y: 0, width: 100, height: 15))
        label.text = "0"
        label.textColor = .yellow
        self.addSubview(label)
        
    }
    
    func initialScroll(){
        let initialScroll = ((self.num_Lines/2)*(self.lineSpacing))
        scrollView.setContentOffset(CGPoint(x: initialScroll , y: 0), animated: false)
        print("mid-OFSET \(scrollView.contentOffset.x)")
        value = 0.0
        label.text = String(Int(value.rounded()))
        print("half scroll = \(scrollView.contentSize.width/2)")
        mid_ofset = scrollView.contentOffset.x
    }

}

extension MyRulerSlider : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let halfNumLines = Double(self.num_Lines / 2)
        let factor = CGFloat((self.maxValue / halfNumLines)/2)

        value = Double(((scrollView.contentOffset.x - mid_ofset)/halfSpace) * factor)
        label.text = String(Int(value.rounded()))
    }

}
