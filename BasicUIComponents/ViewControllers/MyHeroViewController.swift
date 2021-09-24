//
//  MyHeroViewController.swift
//  BasicUIComponents
//
//  Created by 109895 on 24.09.2021.
//

import Foundation
import UIKit
import Hero
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

class MyHeroViewController: MyBasicViewController {
    let redView = UIView()
      let blackView = UIView()

      override func viewDidLoad() {
        super.viewDidLoad()

        redView.backgroundColor = UIColor(rgb: 0xFC3A5E)
        redView.hero.id = "ironMan"
       
        view.addSubview(redView)

        blackView.backgroundColor = UIColor(rgb: 0xFC3A5E)
        blackView.hero.id = "batMan"
      
        view.addSubview(blackView)
      }

      override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        redView.frame.size = CGSize(width: 200, height: 200)
        blackView.frame.size = CGSize(width: 200, height: 80)
        redView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY + 50)
        blackView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY - 90)
      }

      @objc override func onTap() {
        let vc2 = MyHeroViewController2()
        vc2.hero.isEnabled = true
        present(vc2, animated: true, completion: nil)
      }
    }

    class MyHeroViewController2: MyBasicViewController {
      let redView = UIView()
      let blackView = UIView()
      let backgroundView = UIView()

      override func viewDidLoad() {
        super.viewDidLoad()

        redView.backgroundColor = .green
        redView.hero.id = "ironMan"
        view.insertSubview(redView, belowSubview: dismissButton)

        blackView.backgroundColor = .red
        blackView.hero.id = "batMan"

        view.addSubview(blackView)

        if #available(iOS 13.0, tvOS 13, *) {
          backgroundView.backgroundColor = .systemBackground
        } else {
          backgroundView.backgroundColor = .white
        }
        // .useGlobalCoordinateSpace modifier is needed here otherwise it will be covered by redView during transition.
        // see http://lkzhao.com/2018/03/02/hero-useglobalcoordinatespace-explained.html for detail
        backgroundView.hero.modifiers = [.translate(y: 500), .useGlobalCoordinateSpace]
        view.addSubview(backgroundView)
      }

      override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        redView.frame = view.bounds
        blackView.frame.size = CGSize(width: 250, height: 60)
        blackView.center = CGPoint(x: view.bounds.midX, y: 130)
        backgroundView.frame = CGRect(x: (view.bounds.width - 250) / 2, y: 180, width: 250, height: view.bounds.height - 320)
      }
    }
