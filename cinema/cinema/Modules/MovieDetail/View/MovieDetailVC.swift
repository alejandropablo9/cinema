//
//  MovieDetailVC.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 06/06/22.
//
import UIKit
import Combine
final class MovieDetailVC: BaseViewController {
    @IBOutlet fileprivate weak var ivPoster: UIImageView!
    @IBOutlet fileprivate weak var lblName: UILabel!
    @IBOutlet fileprivate weak var lblOriginalName: UILabel!
    @IBOutlet fileprivate weak var lblSynopsis: UILabel!
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    var movie: MovieCellEntity?
    var presenter: MovieDetailPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        if let movieData = movie {
            print(movieData.posterH)
            cancellable = loadImage(for: movieData.posterH).sink { [unowned self] image in
                self.showImage(image: image)
            }
            lblName.text = movieData.name
            lblOriginalName.text = movieData.originalName
            lblSynopsis.text = movieData.synopsis
        }
        let backButton: UIButton = UIButton()
        backButton.setImage(UIImage(named: "arrow-left-circle"), for: UIControl.State())
        backButton.addTarget(self, action:#selector(onBack), for: UIControl.Event.touchUpInside)
        backButton.tintColor = .white
        let leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    @objc func onBack() {
        presenter?.goBack()
    }
    private func loadImage(for poster: String) -> AnyPublisher<UIImage?, Never> {
        return Just(poster)
        .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
            let url = URL.init(string: poster)!
            return ImageLoader.shared.loadImage(from: url)
        })
        .eraseToAnyPublisher()
    }
    private func showImage(image: UIImage?) {
        ivPoster.alpha = 0.0
        animator?.fractionComplete = 0.25
        animator?.stopAnimation(true)
        animator?.finishAnimation(at: .current)
        ivPoster.image = image
        ivPoster.contentMode = .scaleAspectFill
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.ivPoster.alpha = 1.0
        })
    }
}
extension MovieDetailVC: MovieDetailViewProtocol {
}
