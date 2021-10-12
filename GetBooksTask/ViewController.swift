import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var isLoading = false
    var books: Books = []
    var currentPage = 0
    var selectedBook: Book?
    
    func updateBooks(books: Books?){
        isLoading = false
        if books != nil{
            self.books.append(contentsOf: books!)
            self.tableView.reloadData()
        }
    }
    
    //загрузка следующей страницы данных из сети
    func loadData(){
        isLoading = true
        DataReciever.loadBooks(pageNumber: currentPage + 1, completion: updateBooks)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        loadData()
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    // настройка tableView
    func tableViewSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        let tableViewLoadingCellNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(tableViewLoadingCellNib, forCellReuseIdentifier: "loadingCell")
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return books.count
        }else if section == 1{
            return 1
        }else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
            cell.textLabel?.text = self.books[indexPath.row].title
            return cell
        }
        else{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "loadingCell")! as! LoadingCell
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedBook = self.books[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let bvc = storyboard.instantiateViewController(identifier: "BookViewController") as? BookViewController
        {
            bvc.selectedBook = self.books[indexPath.row]
            show(bvc, sender: nil)
        }
    }
    
    //вызов подгрузки следующей страницы при прокрутке вниз
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if(offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading{
            loadData()
        }
    }
}
