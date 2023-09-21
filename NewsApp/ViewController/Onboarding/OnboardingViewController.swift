//
//  OnboardingViewController.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 30/01/2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Properties
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Initialize Onboarding Slides
        slides = [
            OnboardingSlide(description: "Welcome to our news app, your go-to source for breaking news.", title: "Stay Informed. Anytime. Anywhere.", image: #imageLiteral(resourceName: "onboard2")),
            OnboardingSlide(description: "Unlock a personalized news experience that allows you to save news for later: Bookmark and revisit your favorite stories. ", title: "Your News, Your Way", image: #imageLiteral(resourceName: "onboard1")),
            OnboardingSlide(description: "Dive into a diverse world of news categories. Stay informed on a wide range of topics.", title: "Sport, Politics & Anything", image: #imageLiteral(resourceName: "onboard3"))
        ]
        
        pageControl.numberOfPages = slides.count
    }
    
    // MARK: - IBActions
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "HomeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

// MARK: - UICollectionViewDelegate and UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

// MARK: - UILabel Extension
extension UILabel {
    
    func colorString(text: String?, coloredText: String?, color: UIColor? = .red) {
        
        let attributedString = NSMutableAttributedString(string: text!)
        let range = (text! as NSString).range(of: coloredText!)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color!],
                                       range: range)
        self.attributedText = attributedString
    }
}
