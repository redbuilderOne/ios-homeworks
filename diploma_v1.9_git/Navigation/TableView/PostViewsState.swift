
import UIKit

enum PostViewsState {
    case viewIsNotAdded
    case viewIsAdded

    var change: PostViewsState {
        switch self {
        case .viewIsNotAdded: return .viewIsAdded
        case .viewIsAdded: return .viewIsNotAdded
        }
    }
}

var isFirstPostViewTapped = false
var isSecondPostViewTapped = false
var isThirdPostViewTapped = false
var isFourthPostViewTapped = false

var viewsState: PostViewsState = .viewIsNotAdded
var viewsState2: PostViewsState = .viewIsNotAdded
var viewsState3: PostViewsState = .viewIsNotAdded
var viewsState4: PostViewsState = .viewIsNotAdded



