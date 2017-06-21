import UIKit
import Foundation
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var menu: UIView!
    @IBOutlet weak var currentSpeed: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    let lightGray = UIColor(red: 21/255, green: 99/255, blue: 111/255, alpha: 255/255)
    
    override func viewDidLoad() {
        height.constant = 0
        backgroundImage.image = UIImage.circle(diameter: 100, color: lightGray)
        self.view.bringSubview(toFront: currentSpeed)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // two approaches to an animation, can resize the constraint like we do here, or resize the frame like the comments
        height.constant = 79
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
//            var frame = self.menu.frame
//            frame.size.height = 500
//            self.menu.frame = frame
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let speedMPH = manager.location!.speed * 2.23694
        
        if (speedMPH > 0) {
           currentSpeed.text = String(round(speedMPH)) + " mph"
        } else {
            currentSpeed.text = "0.0 mph"
        }
        
        print(manager.location!.speed)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        currentSpeed.text = error.localizedDescription
        print(String(error.localizedDescription))
    }
}

extension UIImage {
    class func circle(diameter: CGFloat, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        
        let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        ctx.setFillColor(color.cgColor)
        ctx.fillEllipse(in: rect)
        ctx.restoreGState()
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return img
    }
}
