import UIKit
import SpriteKit
import ARKit

struct ImageInformation {
    let imageName: String
    let imageFile: UIImage
}

class ViewController: UIViewController, ARSKViewDelegate {

    @IBOutlet var sceneView: ARSKView!
    var selectedImage : ImageInformation?

    var closeButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Close", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.frame = CGRect(x: 0, y: 0, width: 70, height: 40)
        btn.center = CGPoint(x: UIScreen.main.bounds.width*0.15, y: UIScreen.main.bounds.height*0.1)
        btn.layer.cornerRadius = btn.bounds.height/8
        btn.alpha = 1
        btn.isEnabled = true
        return btn
    }()
    
    let images = [
        "soundwave" : ImageInformation(
                imageName: "TheDubstepPreview",
                imageFile: UIImage(named: "Image1")!),
        "secondSoundwave" : ImageInformation(
                imageName: "Ahrix Nova NCS Release",
                imageFile: UIImage(named: "Image2")!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(closeButton)

        closeButton.addTarget(self, action: #selector(closeAction(sender:)), for: .touchUpInside)

        sceneView.delegate = self
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true

        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "TestImages", bundle: nil) else {
            fatalError("Missing reference images")
        }

        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }


    // Pause and resume method
    @objc func closeAction(sender:UIButton) {
        self.performSegue(withIdentifier: "closeCamera", sender: self)
    }

    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        if let imageAnchor = anchor as? ARImageAnchor,
            let referenceImageName = imageAnchor.referenceImage.name,
            let scannedImage =  self.images[referenceImageName] {
            self.selectedImage = scannedImage
            self.performSegue(withIdentifier: "showImageInformation", sender: self)
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImageInformation"{
            if let imageInformationVC = segue.destination as? ImageInformationViewController,
                let actualSelectedImage = selectedImage {
                imageInformationVC.imageInformation = actualSelectedImage
            }
        }
    }
}
