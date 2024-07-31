// 
//  RootNavigation.swift
//  TIL_TCA
//
//  Created by MaraMincho on 7/31/24.
//
import Foundation
import ComposableArchitecture


enum RootNavigationPath {
  case child
}
@Reducer
struct RootNavigation {

  @ObservableState
  struct State {
    var isOnAppear = false
    @Presents var child: ChildNavigation.State? = nil
    @Presents var child2: ChildNavigation.State? = nil
    init () {}
  }

  enum Action {
    case child(PresentationAction<ChildNavigation.Action>)
    case child2(PresentationAction<ChildNavigation.Action>)
    case onAppear(Bool)
    case tappedView
    case tappedView2
  }


  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case let .onAppear(isAppear) :
        if state.isOnAppear {
          return .none
        }
        state.isOnAppear = isAppear
        return .none
      case .tappedView2:
        state.child2 = .init()
        return .none
      case .tappedView :
        state.child = .init()
        return .none
      case .child2:
        return .none
      case .child:
        return .none
      }
    }
    .ifLet(\.$child, action: \.child) {
      ChildNavigation()
        ._printChanges()
    }
    .ifLet(\.$child2, action: \.child2) {
      ChildNavigation()
    }
  }
}

extension Reducer where Self.State == RootNavigation.State, Self.Action == RootNavigation.Action { }
