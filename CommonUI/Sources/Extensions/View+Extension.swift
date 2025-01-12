//
//  View+Extension.swift
//  CommonUI
//
//  Created by Taeyoung Son on 12/1/24.
//

import SwiftUI

import PopupView

// MARK: - PopupView
public extension View {
    func centerPopup<PopupContent: View>(
        isPresented: Binding<Bool>,
        appearFrom: PopupView.Popup<PopupContent>.AppearAnimation = .centerScale,
        @ViewBuilder view: @escaping () -> PopupContent
    ) -> some View {
        popup(
            isPresented: isPresented,
            view: view,
            customize: {
                $0.animation(.smooth(duration: 0.3))
                    .appearFrom(appearFrom)
                    .backgroundColor(.black.opacity(0.5))
                    .position(.center)
                    .dragToDismiss(false)
                    .closeOnTap(false)
            }
        )
    }
    
    func bottomPopup<PopupContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder view: @escaping () -> PopupContent
    ) -> some View {
        popup(
            isPresented: isPresented,
            view: view,
            customize: {
                $0.type(.floater(verticalPadding: 0, useSafeAreaInset: true))
                    .animation(.snappy)
                    .backgroundColor(.black.opacity(0.5))
                    .position(.bottom)
            }
        )
    }
    
    func toastPopup(item: Binding<String?>) -> some View {
        popup(
            item: item,
            itemView: {
                Text($0)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.white)
                    .padding(.init(top: 12, leading: 10, bottom: 12, trailing: 10))
                    .background(Color.black)
                    .cornerRadius(6)
            },
            customize: {
                $0.type(.floater())
                    .animation(.snappy)
                    .autohideIn(5)
            }
        )
    }
}

// MARK: - Set Hidden
public extension View {
    func isHidden(_ hidden: Bool) -> some View {
        return opacity(hidden ? 0 : 1)
    }
}
