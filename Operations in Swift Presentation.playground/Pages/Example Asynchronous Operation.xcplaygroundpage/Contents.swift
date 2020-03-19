//: [Previous](@previous)
/*:
 ## An example of an asynchronous Operation
*/
import Foundation

final class FileUploadOperation: AsyncOperation {

    private let fileURL: URL
    private let targetUploadURL: URL
    private var uploadTask: URLSessionTask?

    init(fileURL: URL, targetUploadURL: URL) {
        self.fileURL = fileURL
        self.targetUploadURL = targetUploadURL
    }

    override func main() {
        uploadTask = URLSession.shared.uploadTask(with: URLRequest(url: targetUploadURL), fromFile: fileURL) { (data, response, error) in
            // Handle the response
            // ...
            // Call finish
            self.finish()
        }
    }

    override func cancel() {
        uploadTask?.cancel()
        super.cancel()
    }
}

//: [Next](@next)
