//
//  ProductsVC.swift
//  ITI Task
//

import UIKit

class ProductsVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBTN: UIButton!
    @IBOutlet weak var profileBTN: UIButton!
    @IBOutlet weak var productsTableView: UITableView!
    
    var user: User!
    var products: [Dictionary<String, Any>] = []
    var productArray:[Product] = []
    var filterProduct:[String] = []
    var filterData:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBTN.layer.cornerRadius =  searchBTN.frame.width/2
        searchBTN.layer.masksToBounds = true
        
        profileBTN.layer.cornerRadius =  profileBTN.frame.width/2
        profileBTN.layer.masksToBounds = true
        
        productsTableView.dataSource = self
        productsTableView.delegate = self
        searchBar.delegate = self
        
        filterData = filterProduct
        
        // API Calling
        ApiManager()
        
    }
    
    // MARK: Networking
    func ApiManager() {
        guard let url = URL(string: "https://dummyjson.com/products") else { return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let myProducts = json["products"] as? [Dictionary<String, Any>] {
                    self?.products = myProducts
                    DispatchQueue.main.async {
                        self?.productsTableView.reloadData()
                    }
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
   
    @IBAction func searchButton(_ sender: Any) {
        self.productsTableView.reloadData()
    }
    
    @IBAction func profileButton(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = sb.instantiateViewController(withIdentifier: "profileID") as! profileVC
        profileVC.user = user
        self.present(profileVC, animated: true)
    }
}

extension ProductsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ProductsCell
        
        let product = products[indexPath.row]
               
        let title = product["title"] as? String ?? "No Title"
        let description = product["description"] as? String ?? "No description"
        let category = product["category"] as? String ?? "No category"
        let stock = product["stock"] as? Double ?? 0
        var rating = product["rating"] as? Double ?? 0
        var price = product["price"] as? Double ?? 0
        
        var productCellDetails = Product(name: title, category: category, stock: "\(stock)", rating: "\(rating)", price: "$\(price)", description: description)
        
        productArray.append(productCellDetails)
        filterProduct.append(title)
        
        cell.productNameInCell.text = title
        cell.productRatingInCell.text = "\(rating)"
        cell.productPriceInCell.text = "$\(price)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        productsTableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(identifier: "ProductDetailsID") as? ProductDetailsVC
        
        let currentCell = productArray[indexPath.row]
        
        if let viewController = vc {
            viewController.product = currentCell
            viewController.index = indexPath.row
            
            self.present(viewController, animated: true)
            
        }
    }
}

// MARK: Search Bar Config
extension ProductsVC: UISearchBarDelegate {
 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterData = []
        if searchText == "" {
            filterData = filterProduct
        }
        
        for word in filterProduct {
            if word.uppercased().contains(searchText.uppercased())
            {
                filterData.append(word)
            }
        }
    }
}
