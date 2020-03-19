import Foundation

public typealias ShortURL = URL
public typealias LongURL = URL

public final class UnfurlURLChainedOperation: ChainedAsyncResultOperation<ShortURL, LongURL, UnfurlURLChainedOperation.Error> {
    public enum Error: Swift.Error {
        case canceled
        case missingInputURL
        case missingRedirectURL
        case underlying(error: Swift.Error)
    }

    private var dataTask: URLSessionTask?

    public init(shortURL: URL) {
        super.init(input: shortURL)
    }

    override final public func main() {
        guard let input = input else { return finish(with: .failure(.missingInputURL)) }
        
        var request = URLRequest(url: input)
        request.httpMethod = "HEAD"

        dataTask = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (_, response, error) in
            if let error = error {
                self?.finish(with: .failure(.underlying(error: error)))
                return
            }

            guard let longURL = response?.url else {
                self?.finish(with: .failure(.missingRedirectURL))
                return
            }

            self?.finish(with: .success(longURL))
        })
        dataTask?.resume()
    }

    override final public func cancel() {
        dataTask?.cancel()
        cancel(with: .canceled)
    }
}
