//
//  Flow.swift
//  MeyerQuizEngine
//
//  Created by gustavo r meyer on 5/8/19.
//  Copyright © 2019 gustavo r meyer. All rights reserved.
//

import Foundation

protocol Router {
    func routeTo(question: String)
}

class Flow {
    let router: Router
    let questions: [String]

    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }

    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion)
        }
    }
}
