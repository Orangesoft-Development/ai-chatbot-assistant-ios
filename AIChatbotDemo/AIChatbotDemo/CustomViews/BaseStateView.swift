//
//  BaseStateView.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 29.01.24.
//

import SwiftUI

/// Handle changes in the state of the given [ViewModel] and display the appropriate view.
struct BaseStateView: View {
    @ObservedObject var viewModel: ViewModel
    let successView: AnyView
    let emptyView: AnyView?
    let errorView: AnyView?
    let loadingView: AnyView?
    
    /// Initialize the view with the given [ViewModel] and views to display in each state.
    ///
    /// - Parameters:
    ///  - viewModel: The [ViewModel] to observe its state.
    ///  - successView: The view to display when the state is [ViewState.success].
    ///  - emptyView: The view to display when the state is [ViewState.empty].
    ///  - errorView: The view to display when the state is [ViewState.error].
    ///  - loadingView: The view to display when the state is [ViewState.loading].
    ///
    ///  - Note: The default value for each view is nil, so you have to provide at least the successView.
    init(viewModel: ViewModel,
         successView: AnyView,
         emptyView: AnyView? = AnyView(InfoMessageView(message: "")),
         errorView: AnyView? = nil,
         loadingView: AnyView? = AnyView(ProgressView())) {
        self.viewModel = viewModel
        self.successView = successView
        self.emptyView = emptyView
        self.errorView = errorView
        self.loadingView = loadingView
    }

    var body: some View {
        ZStack {
            successView
            switch viewModel.state {
            case .initial:
                emptyView
            case .loading:
                loadingView
            case .error(let errorMessage):
                errorView ?? AnyView(InfoMessageView(message: errorMessage))
            case .empty:
                emptyView
            default:
                EmptyView()
            }
        }
    }
}
