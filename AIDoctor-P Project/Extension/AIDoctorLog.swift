//
//  AIDoctorLog.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/03.
//

import Foundation
final public class AIDoctorLog {
    
    public class func debug(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
            let output = items.map { "\($0)" }.joined(separator: separator)
            print("🗣 [\(getCurrentTime())] AIDoctor - \(output)", terminator: terminator)
        #else
            print("🗣 [\(getCurrentTime())] AIDoctor - RELEASE MODE")
        #endif
    }
    
    
    fileprivate class func getCurrentTime() -> String {
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return dateFormatter.string(from: now as Date)
    }
}
