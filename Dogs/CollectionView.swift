//
//  CollectionView.swift
//  TestForURL
//
//  Created by Samuel Asamoah on 6/30/18.
//  Copyright © 2018 Samuel Asamoah. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    
    // error
    
    // error
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.addSubview(Button)
        ButtonConstraints()
        collectionView?.addSubview(Image)
        ImageConstraint ()
    }
    
    let Button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RANDOM DOG", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.red, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.addTarget(self, action: #selector(buttonFunc), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let Image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    @objc func buttonFunc () {
        
        
        guard let url = URL(string: "https://dog.ceo/api/breed/hound/images/random") else {return}
        
        let session = URLSession.shared
        session.dataTask(with: url) { (Data, Responce, Error) in
            if let Data = Data {
                DispatchQueue.main.async { do {
                    let json = try JSONSerialization.jsonObject(with: Data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    if let message = json["message"] as? String {
                        guard let urlTwo = URL(string: message) else {
                            return
                        }
                        let sessionTwo = URLSession.shared
                        sessionTwo.dataTask(with: urlTwo, completionHandler: { (Data, Responce, Error) in
                            DispatchQueue.main.async { if let Data = Data {
                                let URLImage = UIImage(data: Data)
                                self.Image.image = URLImage
                            }
                            if let Responce = Responce {
                                print(Responce)
                             }
                            }
                        }).resume()
                    }
                } catch {
                    print(error)
                }
            }
        }
            
            if let Responce = Responce {
                print(Responce)
            }
        }.resume()
        
        
    }
    
    func ButtonConstraints () {
        
        Button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
        
    }
    
    func ImageConstraint () {
        
        Image.bottomAnchor.constraint(equalTo: Button.topAnchor, constant: -20).isActive = true
        Image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Image.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        Image.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        Image.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    
}
