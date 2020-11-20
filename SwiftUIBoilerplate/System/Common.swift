//
//  Common.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import Foundation

let dateFormatter4log: DateFormatter = { format -> DateFormatter in
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter
}("yyyy/MM/dd HH:mm:ss.SSS")

var _prev_log_message: String? = nil
var _duplicate_log_count = 1

func log(_ msg: String, file: String = #file, line: Int = #line, function: String = #function) {

    var f = "NONE"

    if let _f = file.components(separatedBy: "/").last {
        f = _f.replacingOccurrences(of: ".swift", with: "")
        f = f.replacingOccurrences(of: "ViewController", with: "Vc")
        f = f.replacingOccurrences(of: "Repository", with: "Rp")
        f = f.replacingOccurrences(of: "Interactor", with: "Ir")
        f = f.replacingOccurrences(of: "Presenter", with: "Ps")
    }
    
    let message = "\(f):\(line) [\(function)]: \(msg)"
    
    // 重複ログの抑制
    if let prev = _prev_log_message {
        if prev.elementsEqual(message) {
            _duplicate_log_count += 1
            print("〃", terminator: "")
        } else {
            if _duplicate_log_count > 1 {
                print("\(prev), (\(_duplicate_log_count))")
            }
            _prev_log_message = message
            _duplicate_log_count = 1
            print(message)
        }
    } else {
        _prev_log_message = message
        _duplicate_log_count = 1
        print(message)
    }
}
