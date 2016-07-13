// Copyright 2016 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import AppKit

public typealias View = NSView

public typealias EdgeInsets = NSEdgeInsets

public typealias UserInterfaceLayoutDirection = NSUserInterfaceLayoutDirection

public typealias Application = NSApplication

private var tagAssociatedObjectKey: UInt8 = 0

public extension NSView {

    /**
     Similar to `addSubview()` except if `maintainCoordinates` is true, then the view's frame
     will be adjusted so that its absolute position on the screen does not change.
     */
    func addSubview(view: NSView, maintainCoordinates: Bool) {
        if maintainCoordinates {
            let frame = view.convertRect(view.frame, toView: nil)
            addSubview(view)
            view.frame = view.convertRect(frame, fromView: nil)
        } else {
            addSubview(view)
        }
    }

    @nonobjc
    public var tag: Int {
        set {
            objc_setAssociatedObject(self, &tagAssociatedObjectKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
        get {
            return objc_getAssociatedObject(self, &tagAssociatedObjectKey) as? Int ?? -1
        }
    }
}