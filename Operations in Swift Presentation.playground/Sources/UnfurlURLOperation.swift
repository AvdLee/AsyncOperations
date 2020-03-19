import Foundation

public final class UnfurlURLOperation: AsyncResultOperation<URL, UnfurlURLOperation.Error> {
    public enum Error: Swift.Error {
        case canceled
        case missingRedirectURL
        case underlying(error: Swift.Error)
    }

    private let shortURL: URL
    private var dataTask: URLSessionTask?

    public init(shortURL: URL) {
        self.shortURL = shortURL
    }

    override final public func main() {
        var request = URLRequest(url: shortURL)
        request.httpMethod = "HEAD"

        dataTask = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (_, response, error) in
            guard self?.isCancelled == false else { return }
            if let error = error {
                self?.finish(with: .failure(Error.underlying(error: error)))
                return
            }

            guard let longURL = response?.url else {
                self?.finish(with: .failure(Error.missingRedirectURL))
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
