//: [Previous](@previous)
import Foundation
/*:
 ## An operation can only be executed once
*/
let operation = BlockOperation {
    print("Perform operation")
}
let queue = OperationQueue()
queue.addOperation(operation)

// Enabling this line would result in an exception thrown.
// queue.addOperation(operation)
//: [Next](@next)
