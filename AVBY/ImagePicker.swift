import UIKit
import AVFoundation
import Photos

protocol ImagePickerDelegate: AnyObject {
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType)
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage)
    func cancelButtonDidClick(on imageView: ImagePicker)
}

class ImagePicker: NSObject, UINavigationControllerDelegate {
    private weak var controller: UIImagePickerController?
    weak var delegate: ImagePickerDelegate? = nil
    func dismiss() { controller?.dismiss(animated: true, completion: nil) }
    func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        self.controller = controller
        DispatchQueue.main.async {
            viewController.present(controller, animated: true, completion: nil)
        }
    }
}

extension ImagePicker {
    private func showAlert(targetName: String, completion: ((Bool) -> Void)?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alertVC = UIAlertController(title: "Access to the \(targetName)",
                                            message: "Please provide access to your \(targetName)",
                                            preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action in
                guard   let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                        UIApplication.shared.canOpenURL(settingsUrl) else { completion?(false); return }
                UIApplication.shared.open(settingsUrl, options: [:]) { [weak self] _ in
                    self?.showAlert(targetName: targetName, completion: completion)
                }
            }))
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in completion?(false) }))
            UIApplication.shared.windows.filter { $0.isKeyWindow }.first?
                .rootViewController?.present(alertVC, animated: true, completion: nil)
        }
    }
    func photoGalleryAsscessRequest() {
        PHPhotoLibrary.requestAuthorization { [weak self] result in
            guard let self = self else { return }
            let source = UIImagePickerController.SourceType.photoLibrary
            if result == .authorized {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.imagePicker(self, grantedAccess: result == .authorized, to: source)
                }
            } else {
                self.showAlert(targetName: "photo gallery") { self.delegate?.imagePicker(self, grantedAccess: $0, to: source) }
            }
        }
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: image)
            return
        }

        if let image = info[.originalImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: image)
        } else {
            print("Other source")
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.cancelButtonDidClick(on: self)
    }
}
