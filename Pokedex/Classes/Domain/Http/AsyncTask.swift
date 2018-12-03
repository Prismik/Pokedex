//
//  AsyncTask.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-05.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import Foundation

class AsyncTask {
    weak var owner: TaskFactory?
    var id: UUID

    private(set) var didSucceed: ((_ data: Any?) -> Void)?
    private(set) var didFail: ((_ error: NSError) -> Void)?

    init(uuid: UUID) {
        self.id = uuid
    }

    convenience init() {
        self.init(uuid: UUID())
    }

    func onSuccess(_ handler: @escaping (_ data: Any?) -> Void) -> AsyncTask {
        self.didSucceed = { (_ data: Any?) in
            self.owner?.remove(self)
            handler(data)
        }
        return self
    }

    func onFailure(_ handler: @escaping (_ error: NSError) -> Void) -> AsyncTask {
        self.didFail = { (_ error: NSError) in
            self.owner?.remove(self)
            handler(error)
        }
        return self
    }
}
