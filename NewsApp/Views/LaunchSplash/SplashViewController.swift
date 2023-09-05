//
//  SplashViewController.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 5.09.2023.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    // The animation view that will be used to display the Lottie animation called "splash"
    private let animationView: LottieAnimationView = {
        let lottieAnimationView = LottieAnimationView(name: "splash")
        lottieAnimationView.backgroundColor = .white
        return lottieAnimationView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // wait for 2 secs then go to main page
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.performSegue(withIdentifier: "toMain", sender: nil)
        }
        
        // Add animationView to subview
        view.addSubview(animationView)

        // size and position of the animation view
        animationView.frame = view.bounds
        animationView.center = view.center
        animationView.alpha = 1

        // Start the animation and hide and remove the view when it is completed
        animationView.play { _ in
            UIView.animate(withDuration: 1, animations: { // turn the opacity of the animation view to 0 (completely transparent) in 1 second
                self.animationView.alpha = 0
            }, completion: { _ in
                self.animationView.isHidden = true //Hides the appearance of animation
                self.animationView.removeFromSuperview() //The view is completely removed from the screen
            })
        }
    }
}

