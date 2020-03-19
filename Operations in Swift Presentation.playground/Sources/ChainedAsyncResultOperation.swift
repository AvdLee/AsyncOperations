import Foundation

open class ChainedAsyncResultOperation<Input, Output, Failure>: AsyncResultOperation<Output, Failure> where Failure: Swift.Error {

    private(set) public var input: Input?

    public init(input: Input? = nil) {
        self.input = input
    }

    override public final func start() {
        updateInputFromDependencies()
        super.start()
    }

    /// Updates the input by fetching the output of its dependencies.
    /// Will always get the first output matching dependency.
    /// If `input` is already set, the input from dependencies will be ignored.
    private func updateInputFromDependencies() {
        guard input == nil else { return }
        input = dependencies.compactMap { dependency in
            return (dependency as? ChainedOperationOutputProviding)?.output as? Input
        }.first
    }
}

protocol ChainedOperationOutputProviding {
    var output: Any? { get }
}

extension ChainedAsyncResultOperation: ChainedOperationOutputProviding {
    var output: Any? {
        return try? result?.get()
    }
}
