//
//  Progress.swift
//  Swifty
//
//  Created by Vadim Pavlov on 12/18/17.
//  Copyright © 2017 Vadym Pavlov. All rights reserved.
//

import Foundation

public extension Progress {
    func progressHandler(_ handler: @escaping (Double) -> Void) -> NSKeyValueObservation {
        return self.observe(\.fractionCompleted) { progress, _ in
            handler(progress.fractionCompleted)
        }
    }
}
