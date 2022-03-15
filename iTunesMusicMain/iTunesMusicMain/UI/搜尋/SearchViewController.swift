//
//  SearchViewController.swift
//  iTunesMusicMain
//
//  Created by Andy on 2022/3/15.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var playbackStackView: UIStackView!
    
    private var viewModel: SearchViewModel = {
        return SearchViewModel()
    }()
    
    private var playbackView: PlaybackView = {
        return PlaybackView.new
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "iTunesItemCell", bundle: .main), forCellWithReuseIdentifier: iTunesItemCell.id)
        searchTextField.delegate = self
        searchTextField.returnKeyType = .search
        searchButton.addTarget(self, action: #selector(startSearch), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        playbackView.isHidden = true
        playbackStackView.addArrangedSubview(playbackView)
        playbackView.onClosePlayer = closePlayer
        
        NotificationCenter.default.addObserver(self, selector: #selector(closePlayer), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    @objc func closePlayer() {
        UIView.animate(withDuration: 0.5, animations: { [unowned self] in
            self.playbackView.isHidden = true
        })
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func startSearch() {
        viewModel.startSearch { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.iTunesItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: iTunesItemCell.id, for: indexPath) as? iTunesItemCell {
            cell.config(with: viewModel.iTunesItems[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playbackView.addPlayer(with: viewModel.iTunesItems[indexPath.item])
        UIView.animate(withDuration: 0.5, animations: { [unowned self] in
            self.playbackView.isHidden = false
        })
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: iTunesItemCell.height)
    }
}


//MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.keyword = textField.text ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        startSearch()
        dismissKeyboard()
        return true
    }
}
