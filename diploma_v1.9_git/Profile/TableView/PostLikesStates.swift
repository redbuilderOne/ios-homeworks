
import UIKit

enum PostLikesState {
    case likeIsNotAdded
    case likeIsAdded

    var change: PostLikesState {
        switch self {
        case .likeIsNotAdded: return .likeIsAdded
        case .likeIsAdded: return .likeIsNotAdded
        }
    }
}

var isFirstPostLikesTapped = false
var isSecondPostLikesTapped = false
var isThirdPostLikesTapped = false
var isFourthPostLikesTapped = false

var likesState: PostLikesState = .likeIsNotAdded
var likesState2: PostLikesState = .likeIsNotAdded
var likesState3: PostLikesState = .likeIsNotAdded
var likesState4: PostLikesState = .likeIsNotAdded


