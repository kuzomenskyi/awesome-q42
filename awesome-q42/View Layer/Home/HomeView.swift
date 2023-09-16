//
//  HomeView.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 16.09.2023.
//

import SwiftUI
import Combine

struct HomeView: View {
    // MARK: Constant
    
    // MARK: Private Constant
    
    // MARK: Variable
    var body: some View {
        CheckerView(viewModel: checkerVM)
    }
    
    // MARK: Private Variable
    @StateObject private var viewModel: HomeVM
    @StateObject private var checkerVM: CheckerVM = .mock
    
    // MARK: Init
    init(viewModel: HomeVM) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    
    // MARK: Private Function
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let view = HomeView(viewModel: .mock)
        
        return Group {
            view
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 mini"))
                .previewDisplayName("iPhone 13 mini")
            view
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

