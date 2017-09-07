import Foundation
import CoreTelephony

public let RadioAccessTechnologyNotifierStateDidChange = NSNotification.Name("StateDidChange")

public class RadioAccessTechnologyNotifier {
    
    public static let shared = RadioAccessTechnologyNotifier()
    
    fileprivate let telefonyInfo = CTTelephonyNetworkInfo()
    fileprivate(set) var reachability: Reachability?
    public weak var delegate: RadioAccessTechnologyNotifierDelegate?
    
    fileprivate init() {
        defer {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(radioAccessTechnologyDidChange),
                name:.CTRadioAccessTechnologyDidChange,
                object: nil)
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(reachabilityChanged),
                name: ReachabilityChangedNotification,
                object: nil)
        }
        
        reachability = Reachability()
        try? reachability?.startNotifier()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public fileprivate(set) var currentState: RadioAccessTechnologyNotifierState = .unknown {
        didSet {
            guard currentState != oldValue else {
                return
            }
            
            NotificationCenter.default.post(name: RadioAccessTechnologyNotifierStateDidChange, object: nil)
            delegate?.didChange(to: currentState)
        }
    }
    
    @objc fileprivate func radioAccessTechnologyDidChange() {
        reachabilityChanged()
    }
    
    @objc fileprivate func reachabilityChanged() {
        currentState = getCurrentState()
    }
    
    fileprivate var currentStateOnWWAN: RadioAccessTechnologyNotifierState {
        guard let radioAccessTechnology = telefonyInfo.currentRadioAccessTechnology else {
            return .unknown
        }
        
        switch radioAccessTechnology {
        case CTRadioAccessTechnologyGPRS,
             CTRadioAccessTechnologyEdge,
             CTRadioAccessTechnologyCDMA1x: return .edge
        case CTRadioAccessTechnologyWCDMA,
             CTRadioAccessTechnologyHSDPA,
             CTRadioAccessTechnologyHSUPA,
             CTRadioAccessTechnologyCDMAEVDORev0,
             CTRadioAccessTechnologyCDMAEVDORevA,
             CTRadioAccessTechnologyCDMAEVDORevB,
             CTRadioAccessTechnologyeHRPD: return ._3G
        case CTRadioAccessTechnologyLTE: return .lte
        default:
            return .unknown
        }
    }
    
    fileprivate func getCurrentState() -> RadioAccessTechnologyNotifierState {
        guard let status = reachability?.currentReachabilityStatus else {
            return .unknown
        }
        
        switch status {
        case .reachableViaWiFi:
            return .wifi
        case .reachableViaWWAN:
            return currentStateOnWWAN
        default:
            return .unknown
        }
    }
}

public enum RadioAccessTechnologyNotifierState: String {
    case wifi = "WiFi"
    case lte = "LTE"
    case _3G = "3G"
    case edge = "Edge"
    case unknown = "Unknown"
}

public protocol RadioAccessTechnologyNotifierDelegate: class {
    func didChange(to state: RadioAccessTechnologyNotifierState)
}




