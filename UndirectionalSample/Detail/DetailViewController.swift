//
//  DetailViewController.swift
//  UndirectionalSample
//
//  Created by Matthew Cheok on 4/3/19.
//  Copyright © 2019 Matthew Cheok. All rights reserved.
//

import UIKit
import WebKit

final class DetailViewController: UIViewController {
  let item: JobPosition

  let webView = WKWebView()

  // MARK: Lifecycle

  init(item: JobPosition) {
    self.item = item
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    loadData()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    webView.frame = view.bounds
  }

  // MARK: Private

  private func setupViews() {
    view.addSubview(webView)
  }

  private func loadData() {
    title = item.title
    webView.loadHTMLString(item.description, baseURL: nil)
  }
}
