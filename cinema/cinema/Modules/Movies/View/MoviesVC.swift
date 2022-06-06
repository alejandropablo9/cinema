//
//  MoviesVC.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import UIKit
final class MoviesVC: BaseViewController {
    /// Referencial al presenter
    var presenter: MoviesPresenterProtocol?
    /// Lista de peliculas
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    /// Título
    @IBOutlet fileprivate weak var lblTitle: UILabel!
    /// Movies
    private var movies: [Movie] = []
    /// Rutas
    private var rotues: [Route] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getMovies()
        setCollectionView()
        navigationController?.isNavigationBarHidden = true
        lblTitle.text = "lbl.Movies".localized
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    /// Configuración de la tabla.
    func setCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "MovieCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MovieCell")
    }
}
extension MoviesVC: MoviesViewProtocol {
    func requestSuccess(response: MoviesResponse) {
        self.movies = response.movies
        self.rotues = response.routes
        collectionView.reloadData()
    }
    func requestFailure(error: String) {
        showToast(message: error, style: .failure)
    }
}
extension MoviesVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        if let poster = self.rotues.filter({$0.code == "poster"}).first {
            if let imgMovie = self.movies[indexPath.row].media.filter({$0.code == "poster"}).first {
                let urlImg = (poster.sizes.xLarge ?? "") + imgMovie.resource
                print(urlImg)
                cell.configure(poster: urlImg.replacingOccurrences(of: "http", with: "https"))
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.getSizeView(colums: 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
