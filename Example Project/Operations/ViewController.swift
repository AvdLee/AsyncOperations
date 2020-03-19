//
//  ViewController.swift
//  Operations
//
//  Created by Antoine van der Lee on 07/12/2019.
//  Copyright © 2019 SwiftLee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let queue = OperationQueue()
        let unfurlOperation = UnfurlURLChainedOperation(shortURL: URL(string: "https://bit.ly/33UDb5L")!)
        let fetchTitleOperation = FetchTitleChainedOperation()
        fetchTitleOperation.addDependency(unfurlOperation)
        queue.addOperations([unfurlOperation, fetchTitleOperation], waitUntilFinished: true)
        print("Operation finished with: \(fetchTitleOperation.result!)")

    }


}

