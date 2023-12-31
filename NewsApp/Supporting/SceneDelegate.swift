//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 4.09.2023.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let screenMode = UserDefaults.standard.bool(forKey: "darkMode")
        if let appDelegate = windowScene.windows.first {
            if screenMode {
                appDelegate.overrideUserInterfaceStyle = .dark
            } else {
                appDelegate.overrideUserInterfaceStyle = .light
            }
            
            // Firebase ile giriş yapmış kullanıcıyı kontrol et
            if Auth.auth().currentUser != nil {
                // Kullanıcı giriş yapmış, TabBarViewController'ı göster
                let storyboard = UIStoryboard(name: "Home", bundle: nil) // Storyboard adınızı burada değiştirin
                let tabBarController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! TabBarViewController
                appDelegate.rootViewController = tabBarController
            } else {
                // Kullanıcı giriş yapmamış, onboarding veya giriş ekranını göster
                let hasAppBeenOpenedBefore = UserDefaults.standard.bool(forKey: "hasAppBeenOpenedBefore")
                
                if hasAppBeenOpenedBefore {
                    // Kullanıcı daha önce uygulamayı açtı, ana ekrana geç
                    let storyboard = UIStoryboard(name: "Main", bundle: nil) // Storyboard adınızı burada değiştirin
                    let controller = storyboard.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
                    controller.modalPresentationStyle = .fullScreen
                    controller.modalTransitionStyle = .flipHorizontal
                    appDelegate.rootViewController = controller
                } else {
                    // Kullanıcı ilk kez uygulamayı açıyor, onboarding ekranını göster
                    let storyboard = UIStoryboard(name: "Main", bundle: nil) // Storyboard adınızı burada değiştirin
                    let onboardingController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
                    onboardingController.modalPresentationStyle = .fullScreen
                    onboardingController.modalTransitionStyle = .coverVertical
                    appDelegate.rootViewController = onboardingController
                    
                    // Kullanıcının uygulamayı ilk kez açtığını kaydedin
                    UserDefaults.standard.set(true, forKey: "hasAppBeenOpenedBefore")
                }
            }
        }
    }


    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

