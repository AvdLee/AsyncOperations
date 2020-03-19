//: [Previous](@previous)
import Foundation
/*:
 ## Creating a custom operation
 - Implements the main method
*/
final class ContentImportOperation: Operation {
    let itemProvider: NSItemProvider

    init(itemProvider: NSItemProvider) {
        self.itemProvider = itemProvider
    }

    /// The main method is required for implementing your custom logic.
    override func main() {
        print("importing content")
    }
}

let fileURL = URL(fileURLWithPath: "..")
let itemProvider = NSItemProvider(contentsOf: fileURL)!
var contentImportOperation = ContentImportOperation(itemProvider: itemProvider)

contentImportOperation.completionBlock = {
    print("Importing completed!")
}

let queue = OperationQueue()
queue.addOperation(contentImportOperation)
//: [Next](@next)























final class ContentImportOperationExample: Operation {

    let itemProvider: NSItemProvider

    init(itemProvider: NSItemProvider) {
        self.itemProvider = itemProvider
        super.init()
    }

    override func main() {
        guard !isCancelled else { return }
        print("Importing content..")

        // .. import the content using the item provider

    }
}
