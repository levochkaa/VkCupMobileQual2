// CustomLayout.swift

import SwiftUI

struct CustomLayout: Layout {
    
    let size: CGSize = UIScreen.main.bounds.size
    let spacing: CGFloat = 5
    let padding: CGFloat = 16
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let subviewSizes = subviews.map { proxy in
            return proxy.sizeThatFits(.infinity)
        }
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        for subviewSize in subviewSizes {
            if x > size.width - (padding * 2) - subviewSize.width {
                x = 0
                y += subviewSize.height + spacing
            }
            
            x += subviewSize.width + spacing
        }
        
        y += 40
        
        return CGSize(width: proposal.width ?? size.width, height: y)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let subviewSizes = subviews.map { proxy in
            return proxy.sizeThatFits(.infinity)
        }
        
        var x = bounds.minX
        var y = bounds.minY
        
        for index in subviews.indices {
            let subviewSize = subviewSizes[index]
            let sizeProposal = ProposedViewSize(
                width: subviewSize.width,
                height: subviewSize.height
            )
            
            if x > bounds.maxX - subviewSize.width {
                x = bounds.minX
                y += subviewSize.height + spacing
            }
            
            subviews[index]
                .place(
                    at: CGPoint(x: x, y: y),
                    anchor: .topLeading,
                    proposal: sizeProposal
                )
            
            x += subviewSize.width + spacing
        }
    }
}
