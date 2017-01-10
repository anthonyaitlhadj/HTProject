//
//  App.swift
//  H&T
//
//  Created by aaitlhadj on 10/01/2017.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation

struct App {
    var name: String
    var imageName: String
}

struct AllApps {
    static func getAllApps() -> [App] {
        return [
            App(name: "Go to talk about music", imageName: "musique"),
            App(name: "Go to talk about serie", imageName: "serie"),
            App(name: "Go to talk about movie", imageName: "film")
        ]
    }
}
