import SwiftUI
import PlaygroundSupport

var greeting = "Hello, playground"

struct MyView: View {
    @State private var animationAmount: Bool = false

    var body: some View {
        Button("Suca") {
            self.animationAmount = !self.animationAmount
            //self.animationAmount = true
        }
        .padding(50)
        .background(Color.blue)
        .foregroundColor(Color.black)
        Image(uiImage: UIImage(named: "2021-09-30 23.46.18.jpg")!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 400)
            .scaleEffect(animationAmount ? 1.25 : 0.25)
            .animation(.spring())
            
    }
}
PlaygroundSupport.PlaygroundPage.current.setLiveView(MyView());
