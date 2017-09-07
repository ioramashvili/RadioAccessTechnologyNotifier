<h1 align="center">Detect if network is on Wifi, LTE, 3G or Edge</h1>

## Requirements

- iOS 9.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate TableViewReloadAnimation into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'RadioAccessTechnologyNotifier'
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage

```swift
import RadioAccessTechnologyNotifier

```
in viewDidAppear

```swift
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
```
