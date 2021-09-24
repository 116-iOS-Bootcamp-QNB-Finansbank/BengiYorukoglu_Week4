//
//  BasicViewController.swift
//  BasicUIComponents
//
//  Created by 109895 on 24.09.2021.
//

import Foundation
import UIKit
class MyBasicViewController: UIViewController {
  let dismissButton = UIButton(type: .system)

  override func viewDidLoad() {
    super.viewDidLoad()
    if #available(iOS 13.0, tvOS 13, *) {
      view.backgroundColor = .systemBackground
    } else {
      view.backgroundColor = .white
    }
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))

    dismissButton.setTitle("Back", for: .normal)
    dismissButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    dismissButton.hero.id = "back button"
    view.addSubview(dismissButton)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    dismissButton.sizeToFit()
    dismissButton.center = CGPoint(x: 30, y: 30)
  }

  @objc func back() {
    dismiss(animated: true, completion: nil)
  }

  @objc func onTap() {
    back() // default action is back on tap
  }
}
