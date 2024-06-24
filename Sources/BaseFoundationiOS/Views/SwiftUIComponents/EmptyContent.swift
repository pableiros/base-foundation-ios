//
//  EmptyContent.swift
//
//
//  Created by pablo borquez on 11/06/24.
//

import SwiftUI

public struct EmptyContent: View {
    public let emptySystemName: String
    public let emptyMessage: String
    public let imageWidth: CGFloat
    public let imageHeight: CGFloat
    public let minHeight: CGFloat
    
    public init(emptySystemName: String,
                emptyMessage: String,
                imageWidth: CGFloat = 34,
                imageHeight: CGFloat = 34,
                minHeight: CGFloat = 125) {
        self.emptySystemName = emptySystemName
        self.emptyMessage = emptyMessage
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.minHeight = minHeight
    }
    
    public var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                Image(systemName: self.emptySystemName)
                    .renderingMode(.original)
                    .resizable()
                    .foregroundStyle(.gray)
                    .frame(width: self.imageWidth, height: self.imageHeight)
                Spacer()
            }
            
            Text(self.emptyMessage)
                .foregroundStyle(.gray)
                .fontSystemRounded(.callout)
                .padding([.leading, .trailing, .top])
            
            Spacer()
        }
        .frame(minHeight: self.minHeight)
    }
}
