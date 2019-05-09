//
//  FlowTest.swift
//  MeyerQuizEngineTests
//
//  Created by gustavo r meyer on 5/8/19.
//  Copyright © 2019 gustavo r meyer. All rights reserved.
//

@testable import MeyerQuizEngine
import XCTest

class FlowTest: XCTestCase {
    let router = RouterSpy()

    func test_start_withNoQuestion_doesNotRouteToQuestion() {
        let sut = Flow(questions: [], router: router) // sut means: system under testing

        sut.start()

        XCTAssertTrue(router.routedQuestions.isEmpty)
    }

    func test_start_withOneQuestion_routesToCorrectQuestion() {
        let sut = Flow(questions: ["Q1"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        let sut = Flow(questions: ["Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }

    func test_start_withTwoQuestions_routesToFirstQuestion() {
        let sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }

    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion() {
        let sut = Flow(questions: ["Q1", "Q2"], router: router)
        sut.start()

        router.answerCallback("A1")

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }

    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: ((String) -> Void) = { _ in }

        func routeTo(question: String, answerCallback: @escaping ((String) -> Void)) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}
