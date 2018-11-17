import Foundation

@testable import busping
class AutomaticReloaderSpy: Reloader {

    var performOnRepeat_intervalArg: TimeInterval!
    var performOnRepeat_closureArg: (() -> Void)!
    func performOnRepeat(withInterval interval: TimeInterval, _ closure: @escaping () -> Void) {
        performOnRepeat_intervalArg = interval
        performOnRepeat_closureArg = closure
    }

    var cancelAuomtaticReloadWasCalled: Bool!
    func cancelAutomaticReload() {
        cancelAuomtaticReloadWasCalled = true
    }
}
