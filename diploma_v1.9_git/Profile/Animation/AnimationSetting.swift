
import UIKit

enum State {
    case expanded
    case collapsed

    var change: State {
        switch self {
        case .expanded: return .collapsed
        case .collapsed: return .expanded
        }
    }
}
