import UIKit
import SpriteKit
import ARKit

struct ImageInformation {
    let imageTitle: String
    let imageDescription: String
    let imageFile: UIImage
    let imagePlaceOfDiscovery: String
    let imageYear: String
    let imageMaterial: String
    let soundFileName: String
}

class ViewController: UIViewController, ARSKViewDelegate {

    @IBOutlet weak var sceneView: ARSKView!
    var selectedImage : ImageInformation?
    
    let images = [
        // Asign the name of the image left to ImageInformation
/*        "DE-Bronzehorn" : ImageInformation(
            imageName: "DE_Bronzehorn",
            imageFile: UIImage(named: "Image2")!),
        "DE-Einfuehrung" : ImageInformation(
            imageName: "DE_Einfuehrung",
            imageFile: UIImage(named: "Image2")!),
        "DE-Eisenzeit" : ImageInformation(
            imageName: "DE_Eisenzeit",
            imageFile: UIImage(named: "Image2")!),
        "DE-Einfuehrung" : ImageInformation(
            imageName: "DE_Grafschaft",
            imageFile: UIImage(named: "Image2")!),
        "EN-Bronzehorn" : ImageInformation(
            imageName: "EN_Bronzehorn",
            imageFile: UIImage(named: "Image2")!),
        "EN-Einfuehrung" : ImageInformation(
            imageName: "EN_Einfuehrung",
            imageFile: UIImage(named: "Image2")!),
        "EN-Eisenzeit" : ImageInformation(
            imageName: "EN_Eisenzeit",
            imageFile: UIImage(named: "Image2")!),
        "EN-Grafschaft" : ImageInformation(
            imageName: "EN_Grafschaft",
            imageFile: UIImage(named: "Image2")!)*/
        "de-einfuehrung" : ImageInformation (
                imageTitle: "Fibel",
                imageDescription: "Fibeln waren im frühen Mittelalter verbreitet und wurden zur Befestigung von Umhängen verwendet.",
                imageFile: UIImage(named: "Fibeln")!,
                imagePlaceOfDiscovery: "Irland",
                imageYear: "1. Jahrhundert",
                imageMaterial: "Vergoldetes Eisen",
                soundFileName: "DE_Einfuehrung")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* Dev Informations */
        sceneView.delegate = self
        sceneView.showsFPS = false
        sceneView.showsNodeCount = false

        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }

        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "ARImages", bundle: nil) else {
            fatalError("Missing reference images")
        }

        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])

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
                sceneView.session.pause()
            }
        } else if segue.identifier == "showHelpPages" {
            sceneView.session.pause()
        }
    }

}
