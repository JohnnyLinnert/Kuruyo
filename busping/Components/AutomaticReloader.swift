import Foundation

protocol Reloader {
    func performOnRepeat(withInterval interval: TimeInterval, _ closure: @escaping () -> Void )
    func cancelAutomaticReload()
}

class AutomaticReloader: Reloader {
    private var timer: Timer?

    func performOnRepeat(withInterval interval: TimeInterval, _ closure: @escaping () -> Void ) {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) {
            (_) in
            closure()
        }
    }

    func cancelAutomaticReload() {
        timer?.invalidate()
    }
}
