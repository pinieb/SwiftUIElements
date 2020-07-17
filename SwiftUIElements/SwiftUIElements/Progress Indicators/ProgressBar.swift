//
//  ProgressBar.swift
//  SwiftUIElements
//
//  Created by Pete Biencourt on 7/17/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

import SwiftUI

public struct ProgressBar: View {

    public var progress: CGFloat

    public var trayColor = Color.gray.opacity(0.4)
    public var trayBorderColor = Color.gray.opacity(0.8)
    public var trayBorderWidth: CGFloat = 1

    public var fillColor = Color.accentColor

    public var cornerRadius: CGFloat = 4

    public var barHeight: CGFloat = 10

    public var body: some View {
        ZStack(alignment: .leading) {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .foregroundColor(self.trayColor)
                    .overlay(RoundedRectangle(cornerRadius: self.cornerRadius)
                        .strokeBorder(self.trayBorderColor,
                                      lineWidth: self.trayBorderWidth))

                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .foregroundColor(self.fillColor)
                    .frame(width: geo.size.width * self.getSafeProgress())
                    .animation(.easeInOut)
            }
        }.frame(height: self.barHeight)
    }

    private func getSafeProgress() -> CGFloat {
        if progress < 0 {
            return 0
        }

        if progress > 1 {
            return  1
        }

        return progress
    }
}

struct ProgressBar_Preview_View : View {
    @State var progress: CGFloat = 0.5

    var body: some View {
        VStack(spacing: 50) {
            ProgressBar(progress: self.progress)

            ProgressBar(progress: self.progress, cornerRadius: 0, barHeight: 10)

            ProgressBar(progress: self.progress,
                        trayColor: Color.white.opacity(0.9), trayBorderColor: .purple, trayBorderWidth: 3, fillColor: .green,  barHeight: 20)

            Button(action: { self.progress += 0.1 }) {
                Text("Add Progress")
            }
        }
    }
}

struct ProgressBar_Previews : PreviewProvider {
    static var previews: some View {
        GeometryReader { _ in
            VStack {
                ProgressBar_Preview_View().padding()
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
