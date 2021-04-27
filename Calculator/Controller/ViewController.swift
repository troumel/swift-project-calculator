import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel! // The display screen
    
    private var isFinhsedTypingNumber = true // Semaphore to add multiple numbers on screen.
    
    private var displayValue: Double { // A computed property so we don't convert double to string in multiple places.
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label to a double!")
            }
            return number
        }
        set {
            displayLabel.text = String(format: "%g", newValue) // Formatted to remove trailing zeros
        }
    }
    
    private var calculator = CalculatorLogic()
    
    //MARK: -- Calculation Button Is Pressed
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        // What should happen when a non-number button is pressed
        
        isFinhsedTypingNumber = true // Enter numbers on screen, from the beginning
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
    }
    
    //MARK: -- Number Button Is Pressed
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        // What should happen when a number is entered into the keypad
        
        if let numValue = sender.currentTitle {
            
            if isFinhsedTypingNumber {
                if numValue == "." { // Ignore if dot is pressed first
                    return
                }
                displayLabel.text? = numValue
                isFinhsedTypingNumber = false
            } else {
                if numValue == "." {
                    
                    if displayLabel.text!.contains(".") { // Ignore if already exists dot
                        return
                    }
                    
                }
                displayLabel.text?.append(numValue)
            }
        }
    }
}

