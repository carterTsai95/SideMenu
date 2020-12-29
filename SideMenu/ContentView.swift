//
//  ContentView.swift
//  SideMenu
//
//  Created by Hung-Chun Tsai on 2020-12-28.
//

import SwiftUI
import PureSwiftUI

private let showAnimation = Animation.spring(response: 0.5, dampingFraction: 0.8)

struct ContentView: View {
    
    @State var showMenu = false
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                print($0.translation.width)
                if $0.translation.width < -100 {
                    withAnimation(showAnimation) {
                        self.showMenu = false
                    }
                }
                else if $0.translation.width > 100 {
                    withAnimation(showAnimation) {
                        self.showMenu = true
                    }
                }
            }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    MainView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2.5 : 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        Rectangle()
                            .fillColor(.gray)
                            .opacity(0.7)
                            .frame(width:UIScreen.main.width)
                            .edgesIgnoringSafeArea(.all)
                        MenuView()
                            .frame(width: geometry.size.width/2.5)
                            .transition(.move(edge: .leading))
                        
                    }
                }
                    .gesture(drag)
            }
                .navigationBarTitle("Side Menu", displayMode: .inline)
                .navigationBarItems(leading: (
                    Button(action: {
                        withAnimation(showAnimation) {
                            self.showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
                ))
        }
        .gesture(drag)
    }
}

struct MainView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        
        VStack(spacing: 10){
            Text("Carter, Tsai").fontSize(40).yOffset(-60)
            Text("SwiftUI - Hamburger Menu Animation").yOffset(-60)
            
        }

        Button(action: {
            withAnimation(showAnimation) {
               self.showMenu = true
            }
        }) {
            Text("Show Menu")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
