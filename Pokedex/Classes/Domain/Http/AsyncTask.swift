//
//  AsyncTask.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-05.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import Foundation

class AsyncTask<T> {
    var id: UUID

    private(set) var didSucceed: ((_ data: T?) -> Void)?
    private(set) var didFail: ((_ error: NSError) -> Void)?

    init(uuid: UUID) {
        self.id = uuid
    }

    convenience init() {
        self.init(uuid: UUID())
    }

    func onSuccess(_ handler: @escaping (_ data: T?) -> Void) -> AsyncTask {
        self.didSucceed = { (_ data: T?) in
            TaskFactory.shared.remove(self)
            handler(data)
        }
        return self
    }

    func onFailure(_ handler: @escaping (_ error: NSError) -> Void) -> AsyncTask {
        self.didFail = { (_ error: NSError) in
            TaskFactory.shared.remove(self)
            handler(error)
        }
        return self
    }
}
