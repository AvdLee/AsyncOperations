//: [Previous](@previous)

import Foundation
let queue = OperationQueue()
/*:
 ## Asynchronous operations
 - Run long-running tasks
 - Dispatch to another queue from within the operation
*/
class AsyncOperation: Operation {

    /// This is now a serial queue but could be improved into a concurrent queue. See Sources/AsyncOperation.swift.
    private let lockQueue = DispatchQueue(label: "com.cocoaheads.nl")

    override var isAsynchronous: Bool { true }

    private var _isExecuting: Bool = false
    override var isExecuting: Bool {
        get {
            lockQueue.sync { _isExecuting }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            lockQueue.sync { _isExecuting = newValue }
            didChangeValue(forKey: "isExecuting")
        }
    }

    private var _isFinished: Bool = false
    override var isFinished: Bool {
        get {
            lockQueue.sync { _isFinished }
        }
        set {
            willChangeValue(forKey: "isFinished")
            lockQueue.sync { _isFinished = newValue }
            didChangeValue(forKey: "isFinished")
        }
    }

    override func start() {
        isFinished = false
        isExecuting = true
        main()
    }

    override func main() {
        guard !isCancelled else { return }
        /// Use a dispatch after to mimic the scenario of a long-running task.
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
            print("Perform operation")
            self.finish()
        }
    }

    func finish() {
        isExecuting = false
        isFinished = true
    }
}

let operation = AsyncOperation()
operation.observeStateChanges()
operation.completionBlock = { print("Operation completed") }
queue.addOperations([operation], waitUntilFinished: true)
//: [Next](@next)













// Steps to take:
// 1: Start method and realise there is a get only property
// 2: Implement get set property
// 3: Realize that KVO is needed after running it
// 4: Synchronize access with a serial queue

class AsyncOperationExample: Operation {
    private let lockQueue = DispatchQueue(label: "com.swiftlee.asyncoperation", attributes: .concurrent)

    override var isAsynchronous: Bool {
        return true
    }

    private var _isExecuting: Bool = false
    override private(set) var isExecuting: Bool {
        get {
            return lockQueue.sync { _isExecuting }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            lockQueue.sync(flags: [.barrier]) {
                _isExecuting = newValue
            }
            didChangeValue(forKey: "isExecuting")
        }
    }

    private var _isFinished: Bool = false
    override private(set) var isFinished: Bool {
        get {
            return lockQueue.sync { _isFinished }
        }
        set {
            willChangeValue(forKey: "isFinished")
            lockQueue.sync(flags: [.barrier]) {
                _isFinished = newValue
            }
            didChangeValue(forKey: "isFinished")
        }
    }

    final override func start() {
        print("Starting")
        guard !isCancelled else {
            finish()
            return
        }

        isFinished = false
        isExecuting = true
        main()
    }

    override func main() {
        fatalError("Subclasses must implement `execute` without overriding super.")
    }

    func finish() {
        isExecuting = false
        isFinished = true
    }
}
