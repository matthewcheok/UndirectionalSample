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

  private let apiAdapter = APIAdapter()
  private let tableView = UITableView()
  private let reuseIdentifier = "cell"

  // MARK: Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupViews()
    loadData()
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
    title = "SF Job Positions"
    view.addSubview(tableView)
    tableView.dataSource = self
    tableView.delegate = self
  }

  private func loadData() {
    apiAdapter.fetchJobPositions { (result) in
      switch result {
      case .success(let items):
        self.items = items
        self.tableView.reloadData()

      case .failure(let error):
        print(error)
      }
    }
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
    let item = items[indexPath.row]
    let viewController = DetailViewController(item: item)
    navigationController?.pushViewController(viewController, animated: true)
  }
}
