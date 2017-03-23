

import Foundation
import SystemConfiguration

class Utils {
    static let MILLIS = 1
    static let SECOND_IN_MILLIS = 1000 * MILLIS
    static let MINUTES_IN_MILLIS = 60 * SECOND_IN_MILLIS
    static let HOUR_IN_MILLIS = 60 * MINUTES_IN_MILLIS
    static let DAY_IN_MILLIS = 24 * HOUR_IN_MILLIS
    static let MONTH_IN_MILLIS = 30 * DAY_IN_MILLIS
    static let YEAR_IN_MILLIS = 12 * MONTH_IN_MILLIS
    
    class func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
