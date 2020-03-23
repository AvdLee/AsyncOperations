# Asynchronous Operations in Swift - Playground
This project contains a playground to demonstrate Asynchronous Operations in Swift. It's been used in my presentation that I've performed at Swift Paris and CocoaHeadsNL. Slides from this presentation can be found [here](https://github.com/AvdLee/OperationsPresentation/blob/master/Presentation%20-%20Operations%20in%20Swift.pdf) and a live recording can be found [here](https://youtu.be/T0wMEVBIZMg).

![Swift Version](https://img.shields.io/badge/Swift-5.1-F16D39.svg?style=flat) [![Twitter](https://img.shields.io/badge/twitter-@Twannl-blue.svg?style=flat)](https://twitter.com/twannl)

## Swift Playground

The playground can be used to go over each element of operations. It's great to play around and see what each functionality does. 

It also demonstrate 3 different types of Asynchronous Operations:

- The base `AsyncOperation`: Everything that is needed to create a asynchronous operation
- An `AsyncResultOperation`: An enhanced version of the `AsyncOperation` that adds a `Result<Success, Failure>` type
- The `ChainedAsyncResultOperation`: All of the above but then chainable

## Example Project

The example project references the operation classes and allows you to play around with the code by building an app.

## Interesting resources

All of this content has been published in my chapter for the **[Swift for Good](https://www.swiftforgood.com/)** book. Definitely consider buying the book as all revenue is going to charity. The book is written by 20 different authors from the community and contains high quality Swift content.

You can also find blog posts about Operations on my blog **[SwiftLee](https://www.avanderlee.com/)**:

- [Getting started with Operations and OperationQueues in Swift](https://www.avanderlee.com/swift/operations/)
- [Asynchronous operations for writing concurrent solutions in Swift](https://www.avanderlee.com/swift/asynchronous-operations/)]
- [Advanced asynchronous operations by making use of generics](https://www.avanderlee.com/swift/advanced-asynchronous-operations/)

