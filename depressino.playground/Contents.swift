import UIKit
import PlaygroundSupport
import SwiftUI
import CoreGraphics

public struct WhatsNewView<Content: View>: View {
    private let content: Content

    public init(@ViewBuilder contentProvider: () -> Content){
        content = contentProvider()
    }

    public var body: some View {
        TabView {
            content
        }
        .background(Color.white)
        .frame(width: 500, height: 500, alignment: .center)
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct myView: View {
    @State private var tabIndex = 0
    var body: some View {
        TabView(selection: $tabIndex) {
                    firstView(tabIndex: $tabIndex)
                        .tabItem {
                            Text("Opening")
                        }
                        .tag(0)
                    secondView(tabIndex: $tabIndex)
                        .tabItem {
                            Text("Chap. 1")
                        }
                        .tag(1)
                }
        }
    }

struct firstView: View {
    @Binding var tabIndex: Int
    @State var animationAmount : Bool = false
    
    struct MyButtonStyle: ButtonStyle {
        public func makeBody(configuration: MyButtonStyle.Configuration) -> some View {
            configuration.label
                .opacity(configuration.isPressed ? 1 : 1)
                .scaleEffect(configuration.isPressed ? 0.8 : 1)
        }
    }

    var body: some View {
        
        Button(action: {
            withAnimation(.linear(duration: 1.0)) {
                self.animationAmount = !self.animationAmount
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.tabIndex += 1
                }
            }
            
        }){
            Image(uiImage: UIImage(named: "ciaone")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400)
                .opacity(animationAmount ? 0 : 1)
                
        }.buttonStyle(MyButtonStyle())
            .onAppear(perform: {
                self.animationAmount = false
                self.tabIndex = 0
            })
            .tag(0)
    }
}
struct secondView: View {
    @Binding var tabIndex: Int
        var body: some View {
            Button(action: {
                self.tabIndex += 1;
            }) {
                Text("Change to tab 2")
            }
        }
}
PlaygroundSupport.PlaygroundPage.current.setLiveView(myView());
