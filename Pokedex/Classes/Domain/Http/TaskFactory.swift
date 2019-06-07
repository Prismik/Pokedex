//
//  TaskFactory.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-11-05.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import Foundation

class TaskFactory {
    private var tasks: [String: AsyncTask] = [:]

    static var shared = TaskFactory()

    private init() {

    }
    
    func makeAsync() -> AsyncTask {
        let task = AsyncTask(uuid: UUID())
        tasks[task.id.uuidString] = task
        return task
    }

    func remove(_ task: AsyncTask) {
        tasks.removeValue(forKey: task.id.uuidString)
    }
}
