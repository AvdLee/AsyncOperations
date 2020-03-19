//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
/*:
 ## Advanced Asynchronous operations
 ### Creating a chained asynchronous result operation
*/
protocol ChainedOperationOutputProviding {
    var output: Any? { get }
}

extension AsyncResultOperation: ChainedOperationOutputProviding {
    var output: Any? { try? result.get() }
}

class ChainedAsyncResultOperation<Input, Output, Failure>: AsyncResultOperation<Output, Failure> where Failure: Error {

    private(set) var input: Input?

    init(input: Input? = nil) {
        self.input = input
        super.init()
    }

    override func start() {
        if input == nil {
            updateInputFromDependencies()
        }
        super.start()
    }

    private func updateInputFromDependencies() {
        self.input = dependencies.compactMap { (operation) -> ChainedOperationOutputProviding? in
            return operation as? ChainedOperationOutputProviding
        }.first?.output as? Input
    }

}

/*:
 ## An example of chained operations
 ### Getting the title of an unfurled URL
*/
let queue = OperationQueue()
let unfurlOperation = UnfurlURLChainedOperation(shortURL: URL(string: "https://bit.ly/33UDb5L")!)
unfurlOperation.onResult = { print($0) }
let fetchTitleOperation = FetchTitleChainedOperation()
fetchTitleOperation.onResult = { print($0) }
fetchTitleOperation.addDependency(unfurlOperation)

queue.addOperations([unfurlOperation, fetchTitleOperation], waitUntilFinished: true)
