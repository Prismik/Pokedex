//
//  TaskFactory.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-05.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import Foundation

class TaskFactory {
    private var tasks: [String: AsyncTask<Any>] = [:]

    static var shared = TaskFactory()

    private init() {

    }
    
    func makeAsync<T: Any>(resource: T.Type) -> AsyncTask<T> {
        let task = AsyncTask<T>(uuid: UUID())
        tasks[task.id.uuidString] = task as? AsyncTask<Any>
        return task
    }

    func remove<T>(_ task: AsyncTask<T>) {
        tasks.removeValue(forKey: task.id.uuidString)
    }
}
