//
//  CheckerView.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 16.09.2023.
//

import SwiftUI
import Combine

struct CheckerView: View {
    // MARK: Constant
    
    // MARK: Private Constant
    
    // MARK: Variable
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                let size = geometry.size
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.25), radius: 7, x: 2, y: 2)
                    .frame(width: size.width - 82, height: size.height * 0.517)
                    .position(x: size.width / 2, y: size.height * 0.452)
                
                VStack(spacing: 18) {
                    Group {
                        Group {
                            Text(viewModel.title)
                                .font(.system(size: 16, weight: .regular))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 33.5)
                            Text(viewModel.result.message)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color(hex: "838383"))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 31)
                            
                            viewModel.result.image
                                .resizable()
                                .opacity(0.3)
                                .frame(width: 115, height: 115)
                                .offset(y: 10)
                        }
                        .offset(y: -18)
                        
                        TextField.init("", text: $viewModel.websiteAddress)
                            .modifier(TextFieldModifier(whenToShowPlaceholder: viewModel.websiteAddress.isEmpty, placeholderText: viewModel.placeholder))
                            .frame(height: 39)
                            .padding(.horizontal, 15)
                            .autocapitalization(.none)
                        
                        Text(viewModel.result.result)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color(hex: "838383"))
                            .multilineTextAlignment(.center)
                            .offset(y: 6)
                            .padding(.horizontal, 31)
                    }
                }
                .frame(width: size.width - 82, height: size.height * 0.517)
                .position(x: size.width / 2, y: size.height * 0.452)

                Button {
                    viewModel.check()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .shadow(color: .black.opacity(0.25), radius: 7, x: 2, y: 2)
                        Text(viewModel.buttonTitle)
                            .font(.system(size: 16, weight: .regular))
                        
                        HStack {
                            Spacer()
                            Image("chevron")
                                .resizable()
                                .frame(width: size.height * 0.009, height: size.height * 0.02)
                                .aspectRatio(contentMode: .fit)
                                .padding(.trailing, 19)
                        }
                    }
                }
                .padding(.horizontal, 41)
                .frame(height: 52)
                .buttonStyle(.plain)
                .position(x: size.width / 2, y: size.height - 38)
            }
        }
        .ignoresSafeArea([.keyboard], edges: [.vertical])
    }
    
    // MARK: Private Variable
    @StateObject private var viewModel: CheckerVM
    
    // MARK: Init
    init(viewModel: CheckerVM) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    
    // MARK: Private Function
}

struct CheckerView_Previews: PreviewProvider {
    static var previews: some View {
        let view = CheckerView(viewModel: .mock)
        
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

