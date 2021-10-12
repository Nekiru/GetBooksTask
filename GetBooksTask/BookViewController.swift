import UIKit

class BookViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    var selectedBook: Book?
    override func viewDidLoad() {
        super.viewDidLoad()
        //let selectedBook = ViewController.selectedBook
        if self.selectedBook != nil{
            titleLabel.text = selectedBook?.title
            authorLabel.text = selectedBook?.author
            descriptionTextView.text = selectedBook?.bookDescription
            dateLabel.text = getDateString((selectedBook?.publicationDate)!)
        }
    }
    
    func getDateString(_ date :Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: date)
    }
}
