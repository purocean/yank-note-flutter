import UIKit
import Flutter
import UniformTypeIdentifiers

@objc open class DocumentPicker: NSObject, UIDocumentPickerDelegate {
  var controller: UIViewController
  var result: FlutterResult?

  init(controller: UIViewController) {
    self.controller = controller
  }

  public func start(result: @escaping FlutterResult) {
    self.result = result

    let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.folder])
    documentPicker.delegate = self
    self.controller.present(documentPicker, animated: true, completion: nil)
  }

  public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
    self.result?(url.path)
    // DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    // }

    // // Start accessing a security-scoped resource.
    // guard url.startAccessingSecurityScopedResource() else {
    //   // Handle the failure here.
    //   return
    // }

    // // Make sure you release the security-scoped resource when you finish.
    // defer { url.stopAccessingSecurityScopedResource() }

    // // Use file coordination for reading and writing any of the URL’s content.
    // var error: NSError? = nil
    // NSFileCoordinator().coordinate(readingItemAt: url, error: &error) { (url) in

    //   let keys : [URLResourceKey] = [.nameKey, .isDirectoryKey]

    //   // Get an enumerator for the directory's content.
    //   guard let fileList =
    //     FileManager.default.enumerator(at: url, includingPropertiesForKeys: keys) else {
    //     NSLog("*** Unable to access the contents of \(url.path) ***\n")
    //     return
    //   }

    //   for case let file as URL in fileList {
    //     // Start accessing the content's security-scoped URL.
    //     guard url.startAccessingSecurityScopedResource() else {
    //       // Handle the failure here.
    //       continue
    //     }

    //     // Do something with the file here.
    //     NSLog("chosen file: \(file.lastPathComponent)")

    //     // Make sure you release the security-scoped resource when you finish.
    //     url.stopAccessingSecurityScopedResource()
    //   }
    // }
  }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
    let documentPicker = DocumentPicker(controller: controller)
    let channel = FlutterMethodChannel.init(name: "yank-note-message-channel", binaryMessenger: controller.binaryMessenger);
    channel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if ("pick-folder" == call.method) {
        documentPicker.start(result: result)
      } else {
        result(FlutterMethodNotImplemented);
      }
    });

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
