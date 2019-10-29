/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var valueLbl: UILabel!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var scoreLbl: UILabel!
  var currentValue:Int = 0
  var targetValue:Int = 0
  var score = 0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    score = 0
    scoreLbl.text = "0"
    currentValue = lroundf(slider.value)
    valueLbl.text = String(currentValue)
    repeat {
      targetValue = 50 + Int(arc4random_uniform(100))
    } while targetValue >  100
    
    valueLbl.text = String(targetValue)
    
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func sliderMoved(_ slider: UISlider) {
    valueLbl.text = String(lroundf(slider.value))
  }
  
  @IBAction func showAlert() {
    currentValue = lroundf(slider.value)
    var difference = currentValue - targetValue
    if difference < 0 {
      difference *= -1
    }
    let points = 100 - difference
    score += points
    let message = "You have scored \(points) points"
    let alert = UIAlertController(title: "Hello, World",
                                  message: message,
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: "Awesome", style: .default,
                               handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
    scoreLbl.text = String(score)
  }
  
  @IBAction func onStartOver() {
    slider.value = 75
    self.viewDidLoad()
  }
  
  
  
}

