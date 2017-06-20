import UIKit
import Foundation
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()

    var speed = 0
    
    let formatter = NumberFormatter()
    
    @IBOutlet weak var currentSpeed: UILabel!
    
    override func viewDidLoad() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let speed = manager.location!.speed
        
        currentSpeed.text = String(round(speed))
        print(manager.location!.speed)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        currentSpeed.text = error.localizedDescription
        print(String(error.localizedDescription))
    }
}

