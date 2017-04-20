//
//  ViewController.swift
//  MagicGrid
//
//  Created by Darrell Payne on 4/16/17.
//  Copyright © 2017 Darrell Payne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let numViewPerRow = 15
    var cells = [String: UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.width / CGFloat(numViewPerRow)
        
        for j in 0...30{
            for i in 0...numViewPerRow{
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                cellView.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                view.addSubview(cellView)
                
                let key = "\(i)|\(j)"
                cells[key] = cellView
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        
        
    }
    
    var selectedCell: UIView?
    
    func handlePan(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: view)
        
        let width = view.frame.width / CGFloat(numViewPerRow)
        
        // Calculate which row and column is touched
        let i = Int(location.x / width)
        let j = Int(location.y / width)
        
        let key = "\(i)|\(j)"
        guard let cellView = cells[key] else {return}
        
        if selectedCell != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.selectedCell?.layer.transform = CATransform3DIdentity
                
            }, completion: nil)
        }
        
        selectedCell = cellView
        
        view.bringSubview(toFront: cellView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
            
        }, completion: nil)
//        cellView?.backgroundColor = .white

//        for subview in view.subviews {
//            if subview.frame.contains(location){
//                subview.backgroundColor = .black
//            }
//        }
    }
    
    fileprivate func randomColor() -> UIColor {
        
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }


}

