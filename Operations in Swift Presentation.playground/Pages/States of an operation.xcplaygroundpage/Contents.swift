//: [Previous](@previous)
import Foundation
/*:
 ## Different states of an operation
 Cancelling while executing, before executing, and checking for `isCancelled`.
*/
final class ContentImportOperation: Operation {
    override func main() {
        // We need to consider cancelation to make sure we're not doing unnecessarily work.
        guard !isCancelled else { return }
        print("Perform operation")
    }
}

let operation = ContentImportOperation()
operation.completionBlock = {
    print("Operation completed")
}

// Observe any state changes
let observations = operation.observeStateChanges()

let queue = OperationQueue()
queue.addOperation(operation)

/// Canceling here could still be early enough to actually stop the main() method from executing.
operation.cancel()
//: [Next](@next)















// Add operation.cancel() before and after adding to the queue
// Check for !isCancelled
