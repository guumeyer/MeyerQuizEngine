//
//  Flow.swift
//  MeyerQuizEngine
//
//  Created by gustavo r meyer on 5/8/19.
//  Copyright © 2019 gustavo r meyer. All rights reserved.
//

import Foundation

protocol Router {
    func routeTo(question: String, answerCallback: @escaping  (String) -> Void)
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
            router.routeTo(question: firstQuestion) { [weak self] _ in
                guard let selfStrong = self else { return }
                let firstQuestionIndex = selfStrong.questions.firstIndex(of: firstQuestion)!
                let nextQuestion = selfStrong.questions[firstQuestionIndex + 1]
                selfStrong.router.routeTo(question: nextQuestion) { _ in }
            }
        }
    }
}
