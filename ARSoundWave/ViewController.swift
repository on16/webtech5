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

        "de_fibel" : ImageInformation (
                imageTitle: "Fibel",
                imageDescription: "Fibeln waren im frühen Mittelalter verbreitet und wurden zur Befestigung von Umhängen verwendet.",
                imageFile: UIImage(named: "img_fiebeln")!,
                imagePlaceOfDiscovery: "Irland",
                imageYear: "1850 v. Chr.",
                imageMaterial: "Kupfer",
                soundFileName: "de_fibel"),
        "en_brooch" : ImageInformation (
                imageTitle: "Brooch",
                imageDescription: "Fibulae were very popular in medieval Ireland and were used to fasten garments.",
                imageFile: UIImage(named: "img_fiebeln")!,
                imagePlaceOfDiscovery: "Ireland",
                imageYear: "1850 B.C.",
                imageMaterial: "Copper",
                soundFileName: "en_brooch"),

        "de_glocke" : ImageInformation (
                imageTitle: "Glocke",
                imageDescription: "Diese traditionelle Glocke wird standesgemäß mit dem heiligen Patrick in Verbindung gebracht und war das Symbol des damaligen Krieges.",
                imageFile: UIImage(named: "img_glocke")!,
                imagePlaceOfDiscovery: "Irland",
                imageYear: "1105 v. Chr.",
                imageMaterial: "Bronze und Eisen",
                soundFileName: "de_glocke"),
        "en_bell" : ImageInformation (
                imageTitle: "Bell",
                imageDescription: "This traditional bell is associated with St. Patrick and was the symbol of the war at that time.",
                imageFile: UIImage(named: "img_glocke")!,
                imagePlaceOfDiscovery: "Ireland",
                imageYear: "1105 B.C.",
                imageMaterial: "Bronze and iron",
                soundFileName: "en_bell"),

        "de_steinschaedel" : ImageInformation (
                imageTitle: "Steinschädel",
                imageDescription: "Der Schädel besitzt drei Gesichter und stammt vermutlich aus Corleck. Der Kopf stellt eine jüdische Gottheit mit verschiedenen Gesichtsausdrücken dar.",
                imageFile: UIImage(named: "img_steinschaedel")!,
                imagePlaceOfDiscovery: "Irland",
                imageYear: "1./2. Jh.v. Chr.",
                imageMaterial: "Quarz-Kristall",
                soundFileName: "de_steinschaedel"),
        "en_stonehead" : ImageInformation (
                imageTitle: "Stonehead",
                imageDescription: "The skull has three faces and probably comes from Corleck. The head represents a Jewish deity with different facial expressions.",
                imageFile: UIImage(named: "img_steinschaedel")!,
                imagePlaceOfDiscovery: "Ireland",
                imageYear: "1./2. century B.C.",
                imageMaterial: "Quartz-Crystal",
                soundFileName: "en_stonehead"),

        "de_zierscheibe" : ImageInformation (
                imageTitle: "Zierscheibe",
                imageDescription: "Nur insgesamt sieben dieser Exemplare wurde in Irland gefunden. Alle scheiben weisen ein ähnliches Dekort auf.",
                imageFile: UIImage(named: "img_zierscheibe")!,
                imagePlaceOfDiscovery: "Irland",
                imageYear: "1./2. Jh.v. Chr.",
                imageMaterial: "Bronze",
                soundFileName: "de_zierscheibe"),
        "en_decorativeDisk" : ImageInformation (
                imageTitle: "Decorative disc",
                imageDescription: "Only a total of seven of these specimens were found in Ireland. All discs have a similar decoration.",
                imageFile: UIImage(named: "img_zierscheibe")!,
                imagePlaceOfDiscovery: "Ireland",
                imageYear: "1./2. century B.C.",
                imageMaterial: "Quartz-Crystal",
                soundFileName: "en_decorativeDisk"),
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
