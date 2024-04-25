//
//  Logger.swift
//  Utility
//
//  Created by Taeyoung Son on 2024/04/25.
//

import OSLog

public extension OSLog {
    static let subsystem = Bundle.main.bundleIdentifier!
    static let network = OSLog(subsystem: subsystem, category: "Network")
    static let debug = OSLog(subsystem: subsystem, category: "Debug")
    static let info = OSLog(subsystem: subsystem, category: "Info")
    static let error = OSLog(subsystem: subsystem, category: "Error")
}

public struct Log {
    static private var currentTimeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS XXX"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: Date())
    }
    
    enum Level {
        case debug
        case info
        case network
        case error
        case custom(category: String)
        
        fileprivate var category: String {
            switch self {
            case .debug:
                return "🟡 DEBUG"
            case .info:
                return "🟠 INFO"
            case .network:
                return "🔵 NETWORK"
            case .error:
                return "🔴 ERROR"
            case .custom(let category):
                return "🟢 \(category)"
            }
        }
        
        fileprivate var osLog: OSLog {
            switch self {
            case .debug:
                return OSLog.debug
            case .info:
                return OSLog.info
            case .network:
                return OSLog.network
            case .error:
                return OSLog.error
            case .custom:
                return OSLog.debug
            }
        }
        
        fileprivate var osLogType: OSLogType {
            switch self {
            case .debug:
                return .debug
            case .info:
                return .info
            case .network:
                return .default
            case .error:
                return .error
            case .custom:
                return .debug
            }
        }
    }
    
    static private func log(
        _ file: String,
        _ function: String,
        _ line: Int,
        _ arguments: [Any],
        level: Level
    ) {
        #if DEBUG
        let lastFilePath = file.split(separator: "/").last!
        let message: String = arguments.map({ String(describing: $0) }).joined(separator: " ")
        let logger = Logger(subsystem: OSLog.subsystem, category: level.category)
        let logMessage = "[\(level.category)][\(currentTimeString)][\(lastFilePath)] \(function) \(line) -> \(message)"
        switch level {
        case .debug, .custom:
            logger.debug("\(logMessage, privacy: .public)")
        case .info:
            logger.info("\(logMessage, privacy: .public)")
        case .network:
            logger.log("\(logMessage, privacy: .public)")
        case .error:
            logger.error("\(logMessage, privacy: .public)")
        }
        #endif
    }
}

public extension Log {
    static func debug(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        _ arguments: Any...
    ) {
        log(file, function, line, arguments, level: .debug)
    }

    static func info(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        _ arguments: Any...
    ) {
        log(file, function, line, arguments, level: .info)
    }

    static func network(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        _ arguments: Any...
    ) {
        log(file, function, line, arguments, level: .network)
    }

    static func error(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        _ arguments: Any...
    ) {
        log(file, function, line, arguments, level: .error)
    }

    static func custom(
        category: String,
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        _ arguments: Any...
    ) {
        log(file, function, line, arguments, level: .custom(category: category))
    }
}
