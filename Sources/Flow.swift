//
//  Flow.swift
//  MeyerQuizEngine
//
//  Created by gustavo r meyer on 5/8/19.
//  Copyright © 2019 gustavo r meyer. All rights reserved.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
}

class Flow {
    private let router: Router
    private let questions: [String]

    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }

    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        }
    }

    private func routeNext(from question: String) -> Router.AnswerCallback {
        return { [weak self]  _ in
            guard let selfStrong = self,
                let currentQuestionIndex = selfStrong.questions.firstIndex(of: question),
                (currentQuestionIndex + 1) < selfStrong.questions.count
            else { return }

            let nextQuestion = selfStrong.questions[currentQuestionIndex + 1]
            selfStrong.router.routeTo(question: nextQuestion, answerCallback: selfStrong.routeNext(from: nextQuestion))
        }
    }
}
