import UIKit
import AVFoundation
import AVKit

class ImageInformationViewController : UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playSound: UIButton!

    var imageInformation : ImageInformation?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let actualImageInformation = imageInformation {
            self.nameLabel.text = actualImageInformation.imageName
            self.imageView.image = actualImageInformation.imageFile
        }
    }

    @IBAction func playSound(_ sender: UIButton) {

        guard let path = Bundle.main.path(forResource: "TheDubstepPreview", ofType: "mp3", inDirectory: "AudioFiles") else { return }
        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player

        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}