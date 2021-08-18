//
//  ViewController.swift
//  Calculator
//
//  Created by Daniil on 01.08.2021.
//

import UIKit

class View: UIViewController {
    
    private var countData : (Operand, Operand, String?) = (.init(), .init(), nil) // (firstOperand, secondOperad, operation)
    let presenter = Presenter()
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        .lightContent
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.barTintColor = .white
        let newButtonsView = createButtonsView()
        let newResultView = createResultView((newButtonsView))
        view.addSubview(newButtonsView)
        view.addSubview(newResultView)
    }
    //    MARK: Update result on label
   private func updateResultOnView()
    {
        if let newView = view.subviews[1] as? UILabel
        {
            newView.text = (countData.0.stringValue == "" && countData.1.stringValue == "") ? ("") : ((countData.1.stringValue == "") ? countData.0.stringValue : countData.1.stringValue)
        }
    }
    //    MARK: Func creating ButtonsView
    private func createButtonsView() -> UIView
    {
        let newY = view.frame.height / 3
        let newWidth = view.frame.width
        let newHeight = view.frame.height - newY
        let newView = UIView(frame: CGRect(x: 0, y: newY, width: newWidth, height: newHeight))
        newView.backgroundColor = .black
        // добавить кнопки
        let arrayButtons = createButtons(newView: newView)
        for item in arrayButtons
        {
            newView.addSubview(item)
        }
        return newView
    }
    //    MARK: Func creating buttons
    private func createButtons(newView: UIView) -> [UIButton]
    {
        let xCoordinateValue = newView.frame.width / 4
        let yCoordinateValue = newView.frame.height / 5
        let sizeOfButtons = xCoordinateValue - 15
        var arrayButtons = [UIButton]()
        for _ in 1...19 {arrayButtons.append(UIButton())}
        let symbolArray = ["/", "*", "-", "+", "=", "%" ,"9","6","3",".","±","8","5","2","AC","7","4","1","0"]
        
        for i in 0...18
        {
            switch i {
            case 0...4:
                // set operations buttons
                arrayButtons[i].frame = CGRect(x: xCoordinateValue * 3 , y: yCoordinateValue * CGFloat(i) + 10, width: sizeOfButtons, height: sizeOfButtons)
            case 5...9:
                // set %,9,6,3 , buttons
                arrayButtons[i].frame = CGRect(x: xCoordinateValue * 2 , y: yCoordinateValue * CGFloat(i-5) + 10, width: sizeOfButtons, height: sizeOfButtons)
            case 10...13:
                // set +/-,8,5,3 buttons
                arrayButtons[i].frame = CGRect(x: xCoordinateValue , y: yCoordinateValue * CGFloat(i-10) + 10, width: sizeOfButtons, height: sizeOfButtons)
            case 14...17:
                // set AC,7,4,1 buttons
                arrayButtons[i].frame = CGRect(x: 0 , y: yCoordinateValue * CGFloat(i-14) + 10, width: sizeOfButtons, height: sizeOfButtons)
            default:
                //set zero button
                arrayButtons[i].frame = CGRect(x: 0 , y: yCoordinateValue * 4 + 10, width: sizeOfButtons * 2 + 10, height: sizeOfButtons)
            }
            // set color, form, title && other
            arrayButtons[i].layer.cornerRadius = arrayButtons[i].frame.height / 2
            arrayButtons[i].setTitle(symbolArray[i], for: .normal)
            arrayButtons[i].titleLabel?.textAlignment = .center
            arrayButtons[i].titleLabel?.font = UIFont(name: arrayButtons[i].titleLabel!.font.familyName, size: arrayButtons[i].layer.cornerRadius / 1.5)
            if Int(arrayButtons[i].titleLabel!.text!) != nil
            {
                arrayButtons[i].backgroundColor = .darkGray
            }
            else if i < 5
            {
                arrayButtons[i].backgroundColor = .orange
            }
            else
            {
                arrayButtons[i].backgroundColor = .gray
            }
            //add action for buttons
            arrayButtons[i].addTarget(self, action: #selector(buttonsAction(_ :)), for: .touchUpInside)
        }
        return arrayButtons
    }
     @objc private func buttonsAction(_ sender: UIButton)
    {
        let newData = presenter.updateValues (countData.0, countData.1, countData.2, sender.titleLabel!.text!)
        countData = newData
        updateResultOnView()
    }
    
    //    MARK: Func creating ResultView
    private func createResultView(_ buttonsView : UIView) -> UILabel
    {
        let newHeight = self.view.frame.height - buttonsView.frame.height
        let newLabelView = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: newHeight))
        newLabelView.font = UIFont(name: newLabelView.font.familyName, size: self.view.frame.height / 13)
        newLabelView.backgroundColor = .black
        newLabelView.textAlignment = .right
        newLabelView.textColor = .white
        newLabelView.text = ""
        newLabelView.isUserInteractionEnabled = true
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeFunc))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeFunc))
        swipeLeft.direction = .left
        swipeRight.direction = .right
        newLabelView.addGestureRecognizer(swipeLeft)
        newLabelView.addGestureRecognizer(swipeRight)
        return newLabelView
    }
    @objc private func swipeFunc()
    {
        if countData.1.stringValue != "" { countData.1.stringValue.removeLast()}
        else if countData.0.stringValue != "" { countData.0.stringValue.removeLast()}
        updateResultOnView()
    }
}
