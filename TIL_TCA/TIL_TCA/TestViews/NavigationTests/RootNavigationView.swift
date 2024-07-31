//
//  RootNavigationView.swift
//  TIL_TCA
//
//  Created by MaraMincho on 7/31/24.
//
import ComposableArchitecture
import SwiftUI
import SwiftUINavigationCore

struct RootNavigationView: View {
  // MARK: Reducer

  @Bindable
  var store: StoreOf<RootNavigation>

  // MARK: Init

  init(store: StoreOf<RootNavigation>) {
    self.store = store
  }

  // MARK: Content

  @ViewBuilder
  private func makeContentView() -> some View {
    VStack(spacing: 0) {
      Button {
        store.send(.tappedView)
      } label: {
        Text("RootView")
      }
      Button {
        store.send(.tappedView2)
      } label: {
        Text("RootView")
      }
    }
  }

  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        makeContentView()
          .navigationDestination(item: $store.scope(state: \.child, action: \.child)) { childStore in

            ChildNavigationView(store: childStore)
          }
          .navigationDestination(item: $store.scope(state: \.child2, action: \.child2)) { childStore in
            ChildNavigationView(store: childStore)
          }
      }
    }
    .navigationBarBackButtonHidden()
    .onAppear {
      store.send(.onAppear(true))
    }
  }

  private enum Metrics {}

  private enum Constants {}
}
