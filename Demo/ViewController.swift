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

struct Game {
    let whitePlayer: String
    let blackPlayer: String
    let moves: String
    let opening: String
}

struct GameCellViewModel {
    private let game: Game

    var title: String {
        return "\(game.whitePlayer) - \(game.blackPlayer)"
    }

    var subtitle: String {
        return "\(game.opening): \(game.moves)"
    }

    init(game otherGame: Game) {
        game = otherGame
    }
}

protocol PreparableCell {
    func prepareCell()
}

class Cell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.prepareCell()
        }
    }
}

extension Cell: PreparableCell {
    func prepareCell() {
    }
}

class GameCell: Cell {
    let viewModelProperty = MutableProperty<GameCellViewModel?>(nil)

    var viewModel: GameCellViewModel? {
        get {
            return viewModelProperty.value
        }
        set {
            viewModelProperty.value = newValue
        }
    }

    override func prepareCell() {
        textLabel!.rac_text <~ viewModelProperty.producer.map { $0?.title ?? "" }
        detailTextLabel!.rac_text <~ viewModelProperty.producer.map { $0?.subtitle ?? "" }
    }
}

typealias GameList = [Game]

func modelFromData(data: NSData) -> GameList? {
    let json: AnyObject?
    do {
        try json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
    } catch _ {
        json = nil
    }

    if let json = json as? NSDictionary {
        if let list = json["list"] as? [NSDictionary] {
            print("list: \(list)")
            var allGames: [Game] = []
            for gameDict in list {
                let whitePlayer = gameDict.valueForKeyPath("players.white.userId") as? String
                let blackPlayer = gameDict.valueForKeyPath("players.black.userId") as? String
                let moves = gameDict["moves"] as? String
                let opening = gameDict.valueForKeyPath("opening.name") as? String

                if let whitePlayer = whitePlayer, let blackPlayer = blackPlayer, let moves = moves, let opening = opening {
                    let game = Game(whitePlayer: whitePlayer, blackPlayer: blackPlayer, moves: moves, opening: opening)
                    allGames.append(game)
                }
            }

        return allGames
        }
    }

    return nil
}

struct GameListViewModel {
    let gameList = MutableProperty<GameList?>(nil)
    let apiManager = ApiManager()

    init(gameList otherGameList: GameList?) {
        gameList.value = otherGameList
    }

    init() {
        self.init(gameList: nil)
    }

    var games: [Game] {
        return gameList.value ?? []
    }

    var loading: SignalProducer<Bool, NoError> {
        return gameList.producer.map { return $0 == nil }
    }

    var empty: SignalProducer<Bool, NoError> {
        return gameList.producer.map { $0?.count == 0 }
    }

    func load() {
        gameList <~ apiManager.loadAction.apply().suppressError().delay(2.0, onScheduler: QueueScheduler())
    }
}

//extension GameListViewModel: ViewModelType {}

class ApiManager {
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

    var loadAction: Action<Void, GameList?, NSError> {
        return Action { _ in
            return self.session.rac_dataWithRequest(NSURLRequest(URL: NSURL(string: "http://en.lichess.org/api/game?username=hiimgosu&rated&nb=100&with_opening=1&with_moves=1")!)).map { data, response in modelFromData(data) }
        }
    }
}

class GameListTableModel: ListTableModel<Game> {
    let apiManager = ApiManager()

    init() {
        super.init(producer: SignalProducer<[Game], NoError>.empty)
    }

    func load() {
    //        modelProperty <~
    }
}

class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        
        loadingView.hidesWhenStopped = true
        tableView.registerClass(GameCell.self, forCellReuseIdentifier: "GameCell")

        viewModel.value.model.value.load()

        bindActions()
    }
    
    func bindActions() {
        /// Execute reload table action when viewModel is updated
        reloadTableAction <~ viewModelProducer.flatMap(.Latest) { $0.gameList.producer.mapEmpty() }.observeOn(UIScheduler())
        
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
    typealias T = ViewModelTypeOf<GameListViewModel>

    var viewModelProducer: SignalProducer<GameListViewModel, NoError> {
        return viewModel.producer.flatMap(.Latest) { $0.model.producer }
    }

    func defaultViewModel() -> ViewController.T {
        return ViewModelTypeOf<GameListViewModel>(GameListViewModel())
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.value.model.value.games.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath)

        if let cell = cell as? GameCell {
            let game = viewModel.value.model.value.games[indexPath.row]
            cell.viewModel = GameCellViewModel(game: game)
        }

        return cell
    }
}

extension ViewController: UITableViewDelegate {

}