import Foundation

public extension Operation {
    @discardableResult func observeStateChanges() -> [NSKeyValueObservation] {
        let keyPaths: [KeyPath<Operation, Bool>] = [
            \Operation.isExecuting,
            \Operation.isCancelled,
            \Operation.isFinished
        ]

        return keyPaths.map { keyPath in
            observe(keyPath, options: .new) { (_, value) in
                print("- \(keyPath._kvcKeyPathString!) is now \(value.newValue!)")
            }
        }
    }
}
