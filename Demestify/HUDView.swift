

import UIKit

protocol HUDViewDelegate {
    func HUDViewDelegateDidCancel()
}

class HUDView: UIView {
  
  var stopwatch: StopwatchView
  var gamePoints: CounterLabelView
  
  var hintButton: UIButton!
  var backButton: UIButton!
    
    var delegate:HUDViewDelegate?
  
  //this should never be called
  required init?(coder aDecoder:NSCoder) {
    fatalError("use init(frame:")
  }
  
override init(frame:CGRect) {
    self.stopwatch = StopwatchView(frame:CGRectMake(ScreenWidth/2-150, 0, 300, 100))
    self.stopwatch.setSeconds(0)
    
    //the dynamic points label
    self.gamePoints = CounterLabelView(font: FontHUD, frame: CGRectMake(320, 30, 200, 70))
    gamePoints.textColor = UIColor(red: 0.38, green: 0.098, blue: 0.035, alpha: 1)
    gamePoints.value = 0
    
    super.init(frame:frame)
    
    self.addSubview(gamePoints)
    
    //"points" label
    let pointsLabel = UILabel(frame: CGRectMake(190, 30, 140, 70))
    pointsLabel.backgroundColor = UIColor.clearColor()
    pointsLabel.font = FontHUD
    pointsLabel.text = " Points:"
    self.addSubview(pointsLabel)
    
    self.addSubview(self.stopwatch)
    
    self.userInteractionEnabled = true
    
    //load the back button image
    let backButtonImage = UIImage(named: "btn")!
    self.backButton = UIButton(type: .Custom)
    backButton.setTitle("Back", forState:.Normal)
    backButton.titleLabel?.font = FontHUD
    backButton.setBackgroundImage(backButtonImage, forState: .Normal)
    backButton.frame = CGRectMake(10, 30, backButtonImage.size.width, backButtonImage.size.height)
    backButton.alpha = 0.8
    backButton.addTarget(self, action: "closeAnagramGame", forControlEvents: .TouchUpInside)
    self.addSubview(backButton)
    
    //load the button image
    let hintButtonImage = UIImage(named: "btn")!
    
    //the help button
    self.hintButton = UIButton(type: .Custom)
    hintButton.setTitle("Hint!", forState:.Normal)
    hintButton.titleLabel?.font = FontHUD
    hintButton.setBackgroundImage(hintButtonImage, forState: .Normal)
    hintButton.frame = CGRectMake(ScreenWidth-290, 30, hintButtonImage.size.width, hintButtonImage.size.height)
    hintButton.alpha = 0.8
    self.addSubview(hintButton)
  }
    
    func closeAnagramGame() {
        if delegate != nil {
            delegate?.HUDViewDelegateDidCancel()
        }
    }
  
  override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
    //1 let touches through and only catch the ones on buttons
    let hitView = super.hitTest(point, withEvent: event)
    
    //2
    if hitView is UIButton {
      return hitView
    }
    
    //3
    return nil
  }
  
}
