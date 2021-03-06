//
//  OptionsTests.swift
//
//
//  SwiftySettings
//  Created by Tomasz Gebarowski on 24/08/15.
//  Copyright © 2015 codica Tomasz Gebarowski <gebarowski at gmail.com>.
//  All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
import Quick
import Nimble

@testable import SwiftySettings

class OptionsTests: QuickSpec {
    override func spec() {
        describe("OptionsSection") {

            var optionsSection: OptionsSection? = nil

            beforeEach {
                optionsSection = OptionsSection(key: "section-key",
                                                title: "Section title") {
                    [Option(title: "Option 1", optionId: 1),
                     Option(title: "Option 2", optionId: 2),
                     Option(title: "Option 3", optionId: 3)]
                }
            }

            it("has valid options stored") {
                let options = optionsSection?.items as? [Option]
                expect(options).toNot(beNil())
                expect(options!.count).to(equal(3))
            }

            it("any of options is not moving to previous view controller") {
                let options = optionsSection?.items as? [Option]
                expect(options!.filter {!$0.navigateBack}.count).to(equal(3))
            }

            it("every Option can access its parent container key") {
                let options = optionsSection?.items as? [Option]
                for option in options! {
                    expect(option.container.key).to(equal(optionsSection!.key))
                }
            }

            it("should trigger ValueChanged when value changes") {

                let key = "key1"
                let optionButton = OptionsButton(key: key, title: "Title 1")
                let option1 = Option(title: "Title 1", optionId:1)
                option1.container = optionButton

                triggersChangedValueFor(item: option1,
                                        assertedKey: key,
                                        assertedValue: 1)
            }
        }
    }
}