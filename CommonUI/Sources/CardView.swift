//
//  CardView.swift
//  CommonUI
//
//  Created by Taeyoung Son on 2023/07/08.
//

import SwiftUI

public struct CardView: View {
    
    @State private var bgColor: Color = .green
    @State private var originLangText: String = ""
    
    public var body: some View {
        ZStack {
            bgColor
                .opacity(0.3)
            
            Text(originLangText)
        }
    }
}

struct RepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
