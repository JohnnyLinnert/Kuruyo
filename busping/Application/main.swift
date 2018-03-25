import Foundation
import UIKit

let argv = UnsafeMutableRawPointer(CommandLine.unsafeArgv)
    .bindMemory(
        to: UnsafeMutablePointer<Int8>.self,
        capacity: Int(CommandLine.argc)
)

if NSClassFromString("QuickSpec") != nil {
    UIApplicationMain(
        CommandLine.argc,
        argv,
        NSStringFromClass(UIApplication.self),
        NSStringFromClass(TestingAppDelegate.self)
    )
} else {
    UIApplicationMain(
        CommandLine.argc,
        argv,
        NSStringFromClass(UIApplication.self),
        NSStringFromClass(AppDelegate.self)
    )
}
