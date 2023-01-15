// ContentView.swift

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FirstTypeView()
                .tabItem {
                    Image(systemName: "1.circle.fill")
                }
            
            SecondTypeView()
                .tabItem {
                    Image(systemName: "2.circle.fill")
                }
            
            ThirdTypeView()
                .tabItem {
                    Image(systemName: "3.circle.fill")
                }
            
            FourthTypeView()
                .tabItem {
                    Image(systemName: "4.circle.fill")
                }
            
            FifthTypeView()
                .tabItem {
                    Image(systemName: "5.circle.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
