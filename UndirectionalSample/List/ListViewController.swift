//
//  ViewController.swift
//  UndirectionalSample
//
//  Created by Matthew Cheok on 4/3/19.
//  Copyright © 2019 Matthew Cheok. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
  var items: [JobPosition] = []

  private lazy var store = ListStore(renderer: self)
  private lazy var worker = ListWorker(store: store, actor: self)
  
  private let tableView = UITableView()
  private let reuseIdentifier = "cell"

  // MARK: Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupViews()
    worker.reloadData()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    tableView.frame = view.bounds
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: animated)
    }
  }

  // MARK: Private

  private func setupViews() {
    view.addSubview(tableView)
    tableView.dataSource = self
    tableView.delegate = self
  }

}

extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = items[indexPath.row]

    let cell: UITableViewCell
    if let this = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
      cell = this
    } else {
      cell = UITableViewCell(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    cell.textLabel?.text = item.title
    cell.detailTextLabel?.text = item.location
    cell.accessoryType = .disclosureIndicator
    return cell
  }
}

extension ListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    worker.didSelectRow(at: indexPath.row)
  }
}

extension ListViewController: ListStateRendering {
  func setState(_ state: ListState) {
    title = state.title
    items = state.items
    tableView.reloadData()
  }
}

extension ListViewController: ListViewActing {
  func presentDetailViewController(_ viewController: UIViewController) {
    navigationController?.pushViewController(viewController, animated: true)
  }
}
