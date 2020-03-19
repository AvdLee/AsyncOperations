//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
/*:
 ## Advanced Asynchronous operations
 ### Creating a result driven operation
*/

class AsyncResultOperation<Success, Failure>: AsyncOperation where Failure: Error {

    private(set) var result: Result<Success, Failure>? {
        didSet {
            guard let result = result else { return }
            onResult?(result)
        }
    }

    var onResult: ((_ result: Result<Success, Failure>) -> Void)?

    override func finish() {
        fatalError("You should use finish(with:) to ensure a result")
    }

    func finish(with result: Result<Success, Failure>) {
        self.result = result
        super.finish()
    }

    override func cancel() {
        fatalError("You should use cancel(with:) to ensure a result")
    }

    func cancel(with error: Failure) {
        result = .failure(error)
        super.cancel()
    }
}

/*:
 ## An example of an asynchronous result operation
 ### Unfurling a short URL
*/
let queue = OperationQueue()
let unfurlOperation = UnfurlURLOperation(shortURL: URL(string: "https://bit.ly/33UDb5L")!)
unfurlOperation.onResult = { result in
    print("Operation finished with: \(result)")
}
queue.addOperations([unfurlOperation], waitUntilFinished: false)
//: [Next](@next)
