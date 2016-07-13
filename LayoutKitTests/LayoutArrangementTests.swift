// Copyright 2016 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import XCTest
import LayoutKit

class LayoutArrangementTests: XCTestCase {

    func testAnimation() {

        var captured: View? = nil

        // An empty config block that forces a view to get created.
        let emptyConfig: View -> Void = { _ in }

        let before = InsetLayout(
            inset: 10,
            tag: 1,
            sublayout: StackLayout(
                axis: .vertical,
                distribution: .fillEqualSpacing,
                tag: 2,
                sublayouts: [
                    SizeLayout<View>(
                        width: 100,
                        height: 100,
                        alignment: .topLeading,
                        tag: 3,
                        sublayout: SizeLayout<View>(
                            width: 10,
                            height: 10,
                            alignment: .bottomTrailing,
                            tag: 5,
                            config: { view in
                                captured = view
                            }
                        ),
                        config: emptyConfig
                    ),
                    SizeLayout<View>(
                        width: 80,
                        height: 80,
                        alignment: .bottomTrailing,
                        tag: 6,
                        config: emptyConfig
                    )
                ]
            ),
            config: emptyConfig
        )

        let after = InsetLayout(
            inset: 10,
            tag: 1,
            sublayout: StackLayout(
                axis: .vertical,
                distribution: .fillEqualSpacing,
                tag: 2,
                sublayouts: [
                    SizeLayout<View>(
                        width: 100,
                        height: 100,
                        alignment: .topLeading,
                        tag: 3,
                        config: emptyConfig
                    ),
                    SizeLayout<View>(
                        width: 50,
                        height: 50,
                        alignment: .bottomTrailing,
                        tag: 6,
                        sublayout: SizeLayout<View>(
                            width: 20,
                            height: 20,
                            alignment: .topLeading,
                            tag: 5,
                            config: { view in
                                captured = view
                            }
                        ),
                        config: emptyConfig
                    )
                ]
            ),
            config: emptyConfig
        )

        let rootView = View(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        before.arrangement(width: 250, height: 250).makeViews(inView: rootView)
        XCTAssertEqual(captured?.frame, CGRect(x: 90, y: 90, width: 10, height: 10))

        let animation = after.arrangement(width: 250, height: 250).prepareAnimation(for: rootView, direction: .RightToLeft)
        XCTAssertEqual(captured?.frame, CGRect(x: -60, y: -60, width: 10, height: 10))

        animation.apply()
        XCTAssertEqual(captured?.frame, CGRect(x: 30, y: 0, width: 20, height: 20))
    }
}