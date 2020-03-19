//: [Previous](@previous)
import Foundation
/*:
 ## Adding dependencies between operations
*/
let importOperation = BlockOperation { print("Importing content started") }
importOperation.completionBlock = { print("Importing completed") }

let uploadOperation = BlockOperation { print("Uploading content started") }
uploadOperation.completionBlock = { print("Upload completed") }

// By adding this dependency we make sure that the import operation is always finished before the upload operation.
uploadOperation.addDependency(importOperation)

let queue = OperationQueue()
queue.addOperations([uploadOperation, importOperation], waitUntilFinished: true)
/*:
 ## Cancellation and dependencies
 Make sure to check whether dependencies are cancelled.
*/
final class UploadContentOperation: Operation {
    override func main() {
        /// Whenever a dependency is canceled it does not make sense to execute this operation.
        guard !dependencies.contains(where: { $0.isCancelled }), !isCancelled else {
            return
        }

        print("Uploading content..")
    }
}
//: [Next](@next)







/// Add `!dependencies.contains(where: { $0.isCancelled }),`
