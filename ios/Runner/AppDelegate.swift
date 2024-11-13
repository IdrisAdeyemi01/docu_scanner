import Flutter
import UIKit
import VisionKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, VNDocumentCameraViewControllerDelegate {
    var controller:FlutterViewController?
    var flutterResult: FlutterResult?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      controller = window?.rootViewController as! FlutterViewController
      let channel = FlutterMethodChannel(name: "documentScannerPlatform", binaryMessenger: controller!.binaryMessenger)
      channel.setMethodCallHandler({[self]
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          
          if(call.method == "scan"){
              flutterResult = result
              let vc = VNDocumentCameraViewController()
              vc.delegate = self
              controller!.present(vc, animated: true)
          }else{
              result(FlutterMethodNotImplemented)
              return
          }
          
      })
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        print("Found \(scan.pageCount)")
        let uuid = UUID()
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(uuid).jpg")
        
        for i in 0 ..< scan.pageCount{
            let img = scan.imageOfPage(at: i)
            let imgData = img.jpegData(compressionQuality: 0.5)
            
            fileManager.createFile(atPath: paths as String, contents: imgData, attributes: nil)
            flutterResult!("\(getDirectoryPath())/\(uuid).jpg")
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0]; return documentDirectory
    }
}
