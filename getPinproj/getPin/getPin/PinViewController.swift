//
//  ViewController.swift
//  Passcode
//

import UIKit
protocol PinViewDelegate {
    func childReturn(data: String)  //data: string is an example parameter
    func resetPin() ; // to call register screen 
}
class PinViewController: UIViewController {
    var correctPin = "";
    var delegate: PinViewDelegate?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var topCenterYConstraint:                 NSLayoutConstraint!
    @IBOutlet weak var titleIndentYConstraint:               NSLayoutConstraint!
    @IBOutlet weak var pinsIndentYConstraint:                NSLayoutConstraint!
    @IBOutlet weak var pinDiameterConstraint:                NSLayoutConstraint!
    @IBOutlet weak var distanceBetweenPinsXConstraint:       NSLayoutConstraint!
    @IBOutlet weak var keyDiameterConstraint:                NSLayoutConstraint!
    @IBOutlet weak var distanceBetweenKeysXConstraint:       NSLayoutConstraint!
    @IBOutlet weak var distanceBetweenKeysYConstraint:       NSLayoutConstraint!
    @IBOutlet weak var bottomButtonsIndentCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var pinsViewCenterXConstraint:            NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var pinView1: PinView!
    @IBOutlet weak var pinView2: PinView!
    @IBOutlet weak var pinView3: PinView!
    @IBOutlet weak var pinView4: PinView!
    
    @IBOutlet weak var keyBackgroundView1: UIView!
    @IBOutlet weak var keyBackgroundView2: UIView!
    @IBOutlet weak var keyBackgroundView3: UIView!
    @IBOutlet weak var keyBackgroundView4: UIView!
    @IBOutlet weak var keyBackgroundView5: UIView!
    @IBOutlet weak var keyBackgroundView6: UIView!
    @IBOutlet weak var keyBackgroundView7: UIView!
    @IBOutlet weak var keyBackgroundView8: UIView!
    @IBOutlet weak var keyBackgroundView9: UIView!
    @IBOutlet weak var keyBackgroundView0: UIView!
    
    @IBOutlet weak var keyButton1: PasscodeButton!
    @IBOutlet weak var keyButton2: PasscodeButton!
    @IBOutlet weak var keyButton3: PasscodeButton!
    @IBOutlet weak var keyButton4: PasscodeButton!
    @IBOutlet weak var keyButton5: PasscodeButton!
    @IBOutlet weak var keyButton6: PasscodeButton!
    @IBOutlet weak var keyButton7: PasscodeButton!
    @IBOutlet weak var keyButton8: PasscodeButton!
    @IBOutlet weak var keyButton9: PasscodeButton!
    @IBOutlet weak var keyButton0: PasscodeButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var passcode: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color: UIColor = .white
        let passcodeKeyboard = PasscodeKeyboard()
        
        topCenterYConstraint.constant                 = passcodeKeyboard.topCenterY
        titleIndentYConstraint.constant               = passcodeKeyboard.titleIndentY
        pinsIndentYConstraint.constant                = passcodeKeyboard.pinsIndentY
        pinDiameterConstraint.constant                = passcodeKeyboard.pinDiameter
        distanceBetweenPinsXConstraint.constant       = passcodeKeyboard.distanceBetweenPinsX
        keyDiameterConstraint.constant                = passcodeKeyboard.keyDiameter
        distanceBetweenKeysXConstraint.constant       = passcodeKeyboard.distanceBetweenKeysX
        distanceBetweenKeysYConstraint.constant       = passcodeKeyboard.distanceBetweenKeysY
        bottomButtonsIndentCenterYConstraint.constant = passcodeKeyboard.bottomButtonsIndentCenterY
        
        titleLabel.textColor = color
        titleLabel.font = passcodeKeyboard.titleFont
        
        let pinCornerRadius = passcodeKeyboard.pinDiameter / 2
        pinView1.set(color: color, cornerRadius: pinCornerRadius)
        pinView2.set(color: color, cornerRadius: pinCornerRadius)
        pinView3.set(color: color, cornerRadius: pinCornerRadius)
        pinView4.set(color: color, cornerRadius: pinCornerRadius)
        
        let keyCornerRadius = passcodeKeyboard.keyDiameter / 2
        keyButton1.set(digit: "1", backgroundView: keyBackgroundView1, color: color, cornerRadius: keyCornerRadius)
        keyButton2.set(digit: "2", backgroundView: keyBackgroundView2, color: color, cornerRadius: keyCornerRadius)
        keyButton3.set(digit: "3", backgroundView: keyBackgroundView3, color: color, cornerRadius: keyCornerRadius)
        keyButton4.set(digit: "4", backgroundView: keyBackgroundView4, color: color, cornerRadius: keyCornerRadius)
        keyButton5.set(digit: "5", backgroundView: keyBackgroundView5, color: color, cornerRadius: keyCornerRadius)
        keyButton6.set(digit: "6", backgroundView: keyBackgroundView6, color: color, cornerRadius: keyCornerRadius)
        keyButton7.set(digit: "7", backgroundView: keyBackgroundView7, color: color, cornerRadius: keyCornerRadius)
        keyButton8.set(digit: "8", backgroundView: keyBackgroundView8, color: color, cornerRadius: keyCornerRadius)
        keyButton9.set(digit: "9", backgroundView: keyBackgroundView9, color: color, cornerRadius: keyCornerRadius)
        keyButton0.set(digit: "0", backgroundView: keyBackgroundView0, color: color, cornerRadius: keyCornerRadius)
    }
    
    // MARK: - Action
    @IBAction func resetClk(_ sender: Any) {

        delegate?.resetPin();
    }
    
    @IBAction func touchDownKeyButton(_ sender: PasscodeButton) {
        addKey(sender.digit)
    }
    
    @IBAction func touchUpKeyButton(_ sender: PasscodeButton) {
        checkPasscode()
    }
    
    @IBAction func clickDeleteButton(_ sender: UIButton) {
        cancelKey()
    }
    
    // MARK: - Keys
    
    func addKey(_ digit: String?) {
        guard let digit = digit, passcode.count < 4 else { return }
        
        passcode += digit
        drawPasscode()
    }
    
    func cancelKey() {
        guard !passcode.isEmpty else { return }
        
        passcode.removeLast()
        drawPasscode()
    }
    
    // MARK: - Passcode
    
    func pinView(_ index: Int) -> PinView? {
        switch index {
        case 0:  return pinView1
        case 1:  return pinView2
        case 2:  return pinView3
        case 3:  return pinView4
        default: return nil
        }
    }
    
    func clearPasscode() {
        passcode = ""
        drawPasscode()
    }
    
    func drawPasscode() {
        for i in 0...3 {
            if passcode.count >= i + 1 {
                pinView(i)?.active()
            } else {
                pinView(i)?.inactive()
            }
        }
    }
    
    func checkPasscode() {
        guard passcode.count >= 4 else { return }
        
        view.isUserInteractionEnabled = false
        
        let completion = {
            self.clearPasscode()
            self.view.isUserInteractionEnabled = true
        }
        
        if passcode == correctPin {
            //delegate?.pass(data: passcode);
            correctPasscodeAnimation(completion: completion)
        } else {
            invalidPasscodeAnimation(completion: completion)
        }
    }
    
    // MARK: - Animation
    
    func correctPasscodeAnimation(completion: @escaping (() -> Void)) {
        print("Correct passcode")
        delegate?.childReturn(data: passcode);
        
        UIView.animate(withDuration: 1, animations: {
            // Any animation to your taste
        }, completion: { _ in
            completion();
        })
    }
    
    func invalidPasscodeAnimation(completion: @escaping (() -> Void)) {
        let duration = 0.1
        let steps: [CGFloat] = [-50, 100, -80, 60, -40, 20, -10]
        
        UIView.animateKeyframes(withDuration: duration * Double(steps.count), delay: 0, options: [], animations: {
            var startTime = 0.0
            
            for step in steps {
                UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: duration, animations: {
                    self.pinsViewCenterXConstraint.constant += step
                    self.view.layoutIfNeeded()
                })
                
                startTime += duration
            }
        }, completion: { _ in
            completion()
        })
    }
    
}

class PasscodeButton: UIButton {
    
    private let touchDownPasscodeViewButtonAlpha: CGFloat = 0.6
    private let touchUpPasscodeViewButtonAlpha:   CGFloat = 0.2
    private let buttonAnimate: TimeInterval = 0.35
    private let repeatStep:    TimeInterval = 0.01
    
    var digit: String?
    weak var backgroundView: UIView?
    
    func set(digit: String, backgroundView: UIView, color: UIColor, cornerRadius: CGFloat) {
        self.digit = digit
        self.backgroundView = backgroundView
        
        backgroundView.backgroundColor = color
        backgroundView.alpha = touchUpPasscodeViewButtonAlpha
        backgroundView.layer.cornerRadius = cornerRadius
        backgroundView.clipsToBounds = true
    }
    
    // MARK: - Animation
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                touchDown()
            } else {
                cancelTracking(with: nil)
                touchUp()
            }
        }
    }
    
    private lazy var step: CGFloat = {
        return (touchDownPasscodeViewButtonAlpha - touchUpPasscodeViewButtonAlpha) / CGFloat(buttonAnimate / repeatStep)
    }()
    
    private weak var timer: Timer?
    
    private func stopTimer() {
        timer?.invalidate()
    }
    
    @objc private func touchDown() {
        stopTimer()
        guard let backgroundView = backgroundView else { return }
        backgroundView.alpha = touchDownPasscodeViewButtonAlpha
    }
    
    private func touchUp() {
        timer = Timer.scheduledTimer(timeInterval: repeatStep, target: self, selector: #selector(animation), userInfo: nil, repeats: true)
    }
    
    @objc private func animation() {
        guard let backgroundView = backgroundView else { stopTimer(); return }
        
        let stepAlpha = backgroundView.alpha - step
        
        if stepAlpha > touchUpPasscodeViewButtonAlpha {
            backgroundView.alpha = stepAlpha
        } else {
            backgroundView.alpha = touchUpPasscodeViewButtonAlpha
            stopTimer()
        }
    }
    
}

class PinView: UIView {
    
    private let borderPinSize: CGFloat = 1.2
    private var color: UIColor = .clear
    
    func set(color: UIColor, cornerRadius: CGFloat) {
        self.color = color
        
        layer.borderWidth = borderPinSize
        layer.borderColor = color.cgColor
        backgroundColor = .clear
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    func active() {
        backgroundColor = color
    }
    
    func inactive() {
        backgroundColor = .clear
    }
    
}

class PasscodeKeyboard {
    
    let topCenterY: CGFloat
    
    let titleIndentY: CGFloat
    let titleFont: UIFont
    
    let pinsIndentY: CGFloat
    let pinDiameter: CGFloat
    let distanceBetweenPinsX: CGFloat
    
    let keyDiameter: CGFloat
    let distanceBetweenKeysX: CGFloat
    let distanceBetweenKeysY: CGFloat
    
    let bottomButtonsIndentCenterY: CGFloat
    
    init() {
        var topCenterY: CGFloat!
        switch UIDevice.model {
        case .iPhone4:    topCenterY = -132
        case .iPhone5:    topCenterY = -122
        case .iPhone6:    topCenterY = -128
        case .iPhoneX:    topCenterY = -111
        case .iPhonePlus: topCenterY = -138
        case .iPad_9_7,
             .iPad_10_5,
             .iPad_12_9:  topCenterY = -142
        }
        
        var titleIndentY: CGFloat!
        switch UIDevice.model {
        case .iPhone4:    titleIndentY = 13
        case .iPhone5:    titleIndentY = 18
        case .iPhone6,
             .iPhoneX:    titleIndentY = 24
        case .iPhonePlus,
             .iPad_9_7,
             .iPad_10_5,
             .iPad_12_9:  titleIndentY = 28
        }
        
        var pinsIndentY: CGFloat!
        switch UIDevice.model {
        case .iPhone4:    pinsIndentY = 22
        case .iPhone5:    pinsIndentY = 42
        case .iPhone6:    pinsIndentY = 52
        case .iPhoneX,
             .iPhonePlus: pinsIndentY = 60
        case .iPad_9_7,
             .iPad_10_5,
             .iPad_12_9:  pinsIndentY = 61
        }
        
        var pinDiameter: CGFloat!
        switch UIDevice.model {
        case .iPhone4,
             .iPhone5,
             .iPhone6,
             .iPhoneX,
             .iPhonePlus: pinDiameter = 14
        case .iPad_9_7,
             .iPad_10_5,
             .iPad_12_9:  pinDiameter = 16
        }
        
        var distanceBetweenPinsX: CGFloat!
        switch UIDevice.model {
        case .iPhone4,
             .iPhone5:    distanceBetweenPinsX = 23
        case .iPhone6,
             .iPhoneX:    distanceBetweenPinsX = 24
        case .iPhonePlus: distanceBetweenPinsX = 28
        case .iPad_9_7,
             .iPad_10_5,
             .iPad_12_9:  distanceBetweenPinsX = 30
        }
        
        var keyDiameter: CGFloat!
        switch UIDevice.model {
        case .iPhone4,
             .iPhone5,
             .iPhone6,
             .iPhoneX:    keyDiameter = 76
        case .iPhonePlus,
             .iPad_9_7,
             .iPad_10_5,
             .iPad_12_9:  keyDiameter = 82
        }
        
        var distanceBetweenKeysX: CGFloat!
        switch UIDevice.model {
        case .iPhone4,
             .iPhone5:    distanceBetweenKeysX = 19
        case .iPhone6,
             .iPhoneX:    distanceBetweenKeysX = 27
        case .iPhonePlus,
             .iPad_9_7,
             .iPad_10_5,
             .iPad_12_9:  distanceBetweenKeysX = 32
        }
        
        var distanceBetweenKeysY: CGFloat!
        switch UIDevice.model {
        case .iPhone4,
             .iPhone5:    distanceBetweenKeysY = 12
        case .iPhone6,
             .iPhoneX:    distanceBetweenKeysY = 14
        case .iPhonePlus: distanceBetweenKeysY = 17
        case .iPad_9_7,
             .iPad_10_5,
             .iPad_12_9:  distanceBetweenKeysY = 19
        }
        
        var bottomButtonsIndentCenterY: CGFloat!
        switch UIDevice.model {
        case .iPhone4:    bottomButtonsIndentCenterY = 45
        case .iPhone5:    bottomButtonsIndentCenterY = 73
        case .iPhone6:    bottomButtonsIndentCenterY = 111
        case .iPhoneX:    bottomButtonsIndentCenterY = 148
        case .iPhonePlus: bottomButtonsIndentCenterY = 123
        case .iPad_9_7,
             .iPad_10_5,
             .iPad_12_9:  bottomButtonsIndentCenterY = 0
        }
        
        var titleFont: UIFont!
        switch UIDevice.model {
        case .iPhone4,
             .iPhone5:    titleFont = .systemFont(ofSize: 18)
        case .iPhone6,
             .iPhoneX:    titleFont = .systemFont(ofSize: 20)
        case .iPhonePlus: titleFont = .systemFont(ofSize: 22)
        case .iPad_9_7,
             .iPad_10_5,
             .iPad_12_9:  titleFont = .systemFont(ofSize: 23)
        }
        
        self.topCenterY                 = topCenterY
        self.titleIndentY               = titleIndentY
        self.pinsIndentY                = pinsIndentY
        self.pinDiameter                = pinDiameter
        self.distanceBetweenPinsX       = distanceBetweenPinsX
        self.keyDiameter                = keyDiameter
        self.distanceBetweenKeysX       = distanceBetweenKeysX
        self.distanceBetweenKeysY       = distanceBetweenKeysY
        self.bottomButtonsIndentCenterY = bottomButtonsIndentCenterY
        
        self.titleFont = titleFont
    }
    
}

extension UIScreen {
    
    static let minSize: CGFloat = { return min(main.bounds.size.width, main.bounds.size.height) }()
    static let maxSize: CGFloat = { return max(main.bounds.size.width, main.bounds.size.height) }()
    
    static let minSizeIPhone4:    CGFloat = { return  320 }()
    static let minSizeIPhone5:    CGFloat = { return  320 }()
    static let minSizeIPhone6:    CGFloat = { return  375 }()
    static let minSizeIPhoneX:    CGFloat = { return  375 }()
    static let minSizeIPhonePlus: CGFloat = { return  414 }()
    static let minSizeIPad_9_7:   CGFloat = { return  768 }()
    static let minSizeIPad_10_5:  CGFloat = { return  834 }()
    static let minSizeIPad_12_9:  CGFloat = { return 1024 }()
    
    static let maxSizeIPhone4:    CGFloat = { return  480 }()
    static let maxSizeIPhone5:    CGFloat = { return  568 }()
    static let maxSizeIPhone6:    CGFloat = { return  667 }()
    static let maxSizeIPhonePlus: CGFloat = { return  736 }()
    static let maxSizeIPhoneX:    CGFloat = { return  812 }()
    static let maxSizeIPad_9_7:   CGFloat = { return 1024 }()
    static let maxSizeIPad_10_5:  CGFloat = { return 1112 }()
    static let maxSizeIPad_12_9:  CGFloat = { return 1366 }()
    
}

extension UIDevice {
    
    // MARK: - Model
    
    enum Model: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhoneX
        case iPhonePlus
        case iPad_9_7
        case iPad_10_5
        case iPad_12_9
    }
    
    static var model: Model = {
        let minSize = UIScreen.minSize
        let maxSize = UIScreen.maxSize
        
        if minSize <= UIScreen.minSizeIPhone5 {
            if maxSize <= UIScreen.maxSizeIPhone4       { return .iPhone4    }
            else                                        { return .iPhone5    }
        } else if minSize <= UIScreen.minSizeIPhoneX {
            if maxSize <= UIScreen.maxSizeIPhone6       { return .iPhone6    }
            else                                        { return .iPhoneX    }
        } else if minSize <= UIScreen.minSizeIPhonePlus { return .iPhonePlus }
          else if minSize <= UIScreen.minSizeIPad_9_7   { return .iPad_9_7   }
          else if minSize <= UIScreen.minSizeIPad_10_5  { return .iPad_10_5  }
          else                                          { return .iPad_12_9  }
    }()
    
}
