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
    func test_start_withNoQuestion_doesNotRouteToQuestion() {
        // GIVEN
        let router = RouterSpy()
        let sut = Flow(questions: [], router: router) // sut means: system under testing

        // WHEN
        sut.start()

        // THEN
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }

    func test_start_withOneQuestion_routesToCorrectQuestion() {
        // GIVEN
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)

        // WHEN
        sut.start()

        // THEN
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        // GIVEN
        let router = RouterSpy()
        let sut = Flow(questions: ["Q2"], router: router)

        // WHEN
        sut.start()

        // THEN
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }

    func test_start_withTwoQuestions_routesToFirstQuestion() {
        // GIVEN
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)

        // WHEN
        sut.start()

        // THEN
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

//    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice(){
//        // GIVEN
//        let router = RouterSpy()
//        let sut = Flow(questions: ["Q1","Q2"], router: router)
//
//        // WHEN
//        sut.start()
//        sut.start()
//
//        // THEN
//        XCTAssertEqual(router.routedQuestion, "Q1")
//    }

    class RouterSpy: Router {
        var routedQuestions: [String] = []

        func routeTo(question: String) {
            routedQuestions.append(question)
        }
    }
}
