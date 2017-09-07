import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // set delegate
        RadioAccessTechnologyNotifier.shared.delegate = self
        
        // get notification
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(radioAccessTechnologyNotifierStateDidChange),
            name: RadioAccessTechnologyNotifierStateDidChange,
            object: nil)
    }
    
    func radioAccessTechnologyNotifierStateDidChange() {
        print(RadioAccessTechnologyNotifier.shared.currentState)
    }
}

extension ViewController: RadioAccessTechnologyNotifierDelegate {
    func didChange(to state: RadioAccessTechnologyNotifierState) {
        print(state)
    }
}
