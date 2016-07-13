// Copyright 2016 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import UIKit

/// A TableViewController controller where each cell's content view is a DataBinder.
class TableViewController<ContentViewType: UIView where ContentViewType: DataBinder>: UITableViewController {

    typealias CellType = TableCell<ContentViewType>

    let reuseIdentifier = "cell"
    let data: [CellType.DataType]

    init(data: [CellType.DataType]) {
        self.data = data
        super.init(style: UITableViewStyle.Grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        tableView.registerClass(CellType.self, forCellReuseIdentifier: reuseIdentifier)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CellType = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CellType
        cell.setData(data[indexPath.row])
        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

/// A UITableViewCell cell that adds a DataBinder to its content view.
class TableCell<ContentView: UIView where ContentView: DataBinder>: UITableViewCell, DataBinder {

    lazy var wrappedContentView: ContentView = {
        let v = ContentView()
        v.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(v)
        let views = ["v": v]
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[v]-0-|", options: [], metrics: nil, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[v]-0-|", options: [], metrics: nil, views: views))
        return v
    }()

    func setData(data: ContentView.DataType) {
        wrappedContentView.setData(data)
    }
}
