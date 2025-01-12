//
//  IntroduceView.swift
//  Challenge
//
//  Created by Taeyoung Son on 6/24/24.
//

import SwiftUI

public struct IntroPopupContent: View {
    
    private let confirmAction: () -> Void
    
    init(confirmAction: @escaping () -> Void) {
        self.confirmAction = confirmAction
    }
    
    public var body: some View {
        mainView()
            .background(Color.white)
            .cornerRadius(10)
            .padding(20)
    }
    
    private func mainView() -> some View {
        return VStack {
            Text("intro_title".localized)
            
            Button(
                "confirm".localized,
                action: confirmAction
            )
        }
        .padding()
    }
}

#Preview {
    IntroPopupContent(confirmAction: { })
}
