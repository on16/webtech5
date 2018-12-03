import UIKit

class ImageInformationViewController : UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var imageInformation : ImageInformation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let actualImageInformation = imageInformation {
            self.nameLabel.text = actualImageInformation.imageName
            self.imageView.image = actualImageInformation.imageFile
        }
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
