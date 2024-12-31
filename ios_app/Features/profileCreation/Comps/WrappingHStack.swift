//
//  WrappingHStack.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//


import SwiftUI

struct WrappingHStack: Layout {
    private var horizontalSpacing: CGFloat
    private var verticalSpacing: CGFloat

    init(horizontalSpacing: CGFloat, verticalSpacing: CGFloat? = nil) {
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing ?? horizontalSpacing
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) -> CGSize {
        guard !subviews.isEmpty else { return .zero }

        let maxRowWidth = proposal.width ?? .infinity
        var currentRowWidth: CGFloat = 0
        var totalHeight: CGFloat = 0
        let rowHeight = subviews.map { $0.sizeThatFits(.unspecified).height }.max() ?? 0

        subviews.forEach { subview in
            let subviewWidth = subview.sizeThatFits(.unspecified).width
            if currentRowWidth + subviewWidth + horizontalSpacing > maxRowWidth {
                // Start a new row
                totalHeight += rowHeight + verticalSpacing
                currentRowWidth = subviewWidth
            } else {
                currentRowWidth += subviewWidth + horizontalSpacing
            }
        }

        // Add height for the last row
        totalHeight += rowHeight
        return CGSize(width: maxRowWidth, height: totalHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) {
        guard !subviews.isEmpty else { return }

        let maxRowWidth = bounds.width
        var currentX = bounds.minX
        var currentY = bounds.minY
        let rowHeight = subviews.map { $0.sizeThatFits(.unspecified).height }.max() ?? 0

        subviews.forEach { subview in
            let subviewSize = subview.sizeThatFits(.unspecified)
            if currentX + subviewSize.width > maxRowWidth {
                // Move to the next row
                currentX = bounds.minX
                currentY += rowHeight + verticalSpacing
            }
            subview.place(
                at: CGPoint(x: currentX + subviewSize.width / 2, y: currentY + rowHeight / 2),
                anchor: .center,
                proposal: ProposedViewSize(width: subviewSize.width, height: subviewSize.height)
            )
            currentX += subviewSize.width + horizontalSpacing
        }
    }
}
