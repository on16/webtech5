import UIKit
import AVFoundation
import AVKit

class ImageInformationViewController : UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playSound: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var creator: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var type: UILabel!
    
    var imageInformation : ImageInformation?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let actualImageInformation = imageInformation {
            self.nameLabel.text = actualImageInformation.imageTitle
            self.descriptionLabel.text = actualImageInformation.imageDescription
            self.creator.text = actualImageInformation.imageCreator
            self.year.text = actualImageInformation.imageYear
            self.type.text = actualImageInformation.imageType
            imageView.image = actualImageInformation.imageFile
            self.view.addSubview(imageView)
        }
    }
    

    @IBAction func playSound(_ sender: UIButton) {

        let soundFileName = imageInformation?.soundFileName
        let imageFile = imageInformation?.imageFile

        guard let path = Bundle.main.path(
                forResource: soundFileName, ofType: "mp3", inDirectory: "AudioFiles"
        ) else {
            return
        }

        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player

        self.present(playerViewController, animated: true) {

            if let frame = playerViewController.contentOverlayView?.bounds{
                let imageView = UIImageView(image: imageFile)
                imageView.frame = frame
                imageView.contentMode = .scaleAspectFill
                playerViewController.contentOverlayView?.addSubview(imageView)
            }

            playerViewController.player!.play()
        }
    }
    @IBAction func dismissView(_ sender: Any) {}
}
