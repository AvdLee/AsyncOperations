import Foundation

/*:
 ## The operation Queue
 #### A high-level implementation of the Dispatch Queue
 Advantages include:
 - Cancellation
 - Max concurrent operations
 */
let queue = OperationQueue()
/*:
 ## (NS)Operation
 #### A high-level implementation of a Dispatch Block
 Advantages include:
 - Long-running tasks
 - Subclassing
 */
let blockOperation = BlockOperation {
    print("Executing operation!")
}
blockOperation.completionBlock = {
    print("Completed operation!")
}

queue.addOperation(blockOperation)
/*:
## The shorter version of a block operation
*/
queue.addOperation {
    print("Executing short block operation!")
}
//: [Next](@next)
