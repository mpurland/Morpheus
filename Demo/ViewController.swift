//
//  ViewController.swift
//  Demo
//
//  Created by Matthew Purland on 12/9/15.
//  Copyright © 2015 Matthew Purland. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveBind
import Morpheus

class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        
        loadingView.hidesWhenStopped = true
        tableView.registerClass(GameCell.self, forCellReuseIdentifier: "GameCell")

        bindActions()
    }
    
    func bindActions() {
        /// Execute reload table action when viewModel is updated
        reloadTableAction <~ viewModelProducer.flatMap(.Latest) { $0.model.producer.mapEmpty() }.observeOn(UIScheduler())
        
        /// Toggle loading when loading on view model is updated
        toggleLoadingAction <~ viewModelProducer.flatMap(.Latest) { $0.loading }.observeOn(UIScheduler())
    }

    func reloadTable() {
        tableView.reloadData()
    }

    func toggleLoading(loading: Bool) {
        if loading {
            tableView.alpha = 0.0
            loadingView.startAnimating()
        }
        else {
            tableView.alpha = 1.0
            loadingView.stopAnimating()
        }
    }

    // MARK: - Actions

    lazy var reloadTableAction: Action<Void, Void, NoError> = {
        return Action<Void, Void, NoError> { [weak self] in
            print("reloading table")
            self?.reloadTable()
            return SignalProducer<Void, NoError>.empty
        }
    }()

    lazy var toggleLoadingAction: Action<Bool, Void, NoError> = {
        return Action<Bool, Void, NoError> { [weak self] loading in
            print("toggling loading: \(loading)")
            self?.toggleLoading(loading)
            return SignalProducer<Void, NoError>.empty
        }
    }()
}

extension ViewController: ViewModelableBindable {
    typealias T = GameListViewModel
    
    func defaultViewModel() -> ViewController.T {
        return GameListViewModel()
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.value.model.value?.games.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath)

        if let cell = cell as? GameCell, game = viewModel.value.model.value?.games[indexPath.row] {
            cell.viewModel = GameCellViewModel(game: game)
        }

        return cell
    }
}

extension ViewController: UITableViewDelegate {

}