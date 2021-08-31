import UIKit
import Flutter
import AVFoundation
import FLEX

var openTimer = false;

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        #if DEBUG
        application.isIdleTimerDisabled = true
        print("DEBUG模式禁止锁屏")
        #endif
        if (openTimer){
            if #available(iOS 10.0, *) {
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (_) in
                    print("native timer: \(Date())")
                }
            } else {
                // Fallback on earlier versions
            }
        }
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
//            AVAudioSession.sharedInstance().requestRecordPermission({status in
//                print("status = \(status)");
//            });
//        }
        
        FLEXManager.shared().showExplorer()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
