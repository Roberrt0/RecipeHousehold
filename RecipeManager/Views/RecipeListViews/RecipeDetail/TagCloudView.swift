//
//  RecipeDetailTags.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 14/09/24.
//

import SwiftUI

/* 
 (SwiftUI HStack with Wrap)

Tested with Xcode 11.4 / iOS 13.4

Note: as height of view is calculated dynamically the result works in run-time, not in Preview

enter image description here
*/

struct TagCloudView: View {
    
    var tags: [TagModel]

    @State private var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.tags) { tag in
                self.item(for: tag.title, style: tag.swiftUIColor)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: String, style: Color) -> some View {
        Text(text)
            .padding(.all, 5)
            .font(.body)
            .background(style)
            .foregroundColor(Color.white)
            .cornerRadius(5)
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct TestTagCloudView : View {
    var body: some View {
        VStack {
            Text("Recipe's Tags").font(.largeTitle)
            TagCloudView(tags: TagsMockData.getData())
        }
    }
}

#Preview {
    TestTagCloudView()
}
