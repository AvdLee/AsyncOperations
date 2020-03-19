//: [Previous](@previous)
import Foundation
/*:
 ## Order of excution
 ### Demonstrating queue priority and quality of service
*/
let backgroundOperation = BlockOperation {
    print("Background operation!")
}
let userTriggeredOperation = BlockOperation {
    print("User triggered operation!")
}

// There are two ways of setting an operation's priority that affects the order of execution.
userTriggeredOperation.queuePriority = .veryHigh
userTriggeredOperation.qualityOfService = .userInitiated

let queue = OperationQueue()
queue.addOperations([backgroundOperation, userTriggeredOperation], waitUntilFinished: true)
//: [Next](@next)
