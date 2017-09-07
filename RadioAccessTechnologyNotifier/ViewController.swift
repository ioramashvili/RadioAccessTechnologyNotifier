import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // initialize delegate
        RadioAccessTechnologyNotifier.shared.delegate = self
        
        // get notification
        NotificationCenter.default.addObserver(self, selector: #selector(stateDidChange),name: RadioAccessTechnologyNotifierStateDidChange, object: nil)
    }
    
    func stateDidChange() {
        print(RadioAccessTechnologyNotifier.shared.currentState)
    }
}

extension ViewController: RadioAccessTechnologyNotifierDelegate {
    func didChange(to state: RadioAccessTechnologyNotifierState) {
        print(state)
    }
}
