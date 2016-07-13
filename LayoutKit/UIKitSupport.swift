// Copyright 2016 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import UIKit

public typealias View = UIView

public typealias EdgeInsets = UIEdgeInsets

public typealias UserInterfaceLayoutDirection = UIUserInterfaceLayoutDirection

public typealias Application = UIApplication

extension UIView {

    /**
     Similar to `addSubview()` except if `maintainCoordinates` is true, then the view's frame
     will be adjusted so that its absolute position on the screen does not change.
     */
    func addSubview(view: UIView, maintainCoordinates: Bool) {
        if maintainCoordinates {
            let frame = view.convertRect(view.frame, toCoordinateSpace: UIScreen.mainScreen().fixedCoordinateSpace)
            addSubview(view)
            view.frame = view.convertRect(frame, fromCoordinateSpace: UIScreen.mainScreen().fixedCoordinateSpace)
        } else {
            addSubview(view)
        }
    }
}