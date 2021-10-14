import UIKit
import PlaygroundSupport
import SwiftUI
import CoreGraphics
import AVFoundation
import Combine

var HappyMusic: AVAudioPlayer?
var FlipPage: AVAudioPlayer?
var SadMusic: AVAudioPlayer?

var path = Bundle.main.path(forResource: "happy", ofType:"mp3")!
var url = URL(fileURLWithPath: path)
var path2 = Bundle.main.path(forResource: "page-flip-02", ofType:"mp3")!
var url2 = URL(fileURLWithPath: path2)
var path3 = Bundle.main.path(forResource: "sad-music", ofType:"mp3")!
var url3 = URL(fileURLWithPath: path3)


let seconds = 5.0//Time To Delay
let when = DispatchTime.now() + seconds

do{
    HappyMusic = try
    AVAudioPlayer(contentsOf: url)
    FlipPage = try
    AVAudioPlayer(contentsOf: url2)
    SadMusic = try
    AVAudioPlayer(contentsOf: url3)
    
} catch {
    // couldn't load file :(
}


public struct WhatsNewView<Content: View>: View {
    private let content: Content
    private var controller = UITabBarController()
    
    

    public init(@ViewBuilder contentProvider: () -> Content){
        content = contentProvider()
        self.controller.navigationItem.rightBarButtonItem = nil
        
        
        
       
                
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
        
        
        /*controller.moreNavigationController.navigationBar.isHidden = true*/
        
                
    }
    
    
    
}


struct myView: View {
    @State private var tabIndex = 0
    
   
    var body: some View {
        
        TabView(selection: $tabIndex) {
                    introView(tabIndex: $tabIndex)
                        .tabItem {
                            Text("Opening")
                        }
                        .tag(0)
                        .onAppear {
                            FlipPage?.stop()
                            if HappyMusic?.isPlaying == true{
                                HappyMusic?.stop()
                                
                            }
                            if SadMusic?.isPlaying == true{
                                SadMusic?.stop()
                                
                            }
                        }
                    tav1(tabIndex: $tabIndex)
                        .tabItem {
                            Text("Chap. 1")
                        }
                        .tag(1)
                        .onAppear {
                            if HappyMusic?.isPlaying == true{
                                HappyMusic?.stop()
                                
                            }
                            if SadMusic?.isPlaying == false {
                                SadMusic?.setVolume(0, fadeDuration: 0)
                                SadMusic?.play()
                                SadMusic?.setVolume(0.5, fadeDuration: 4)
                                
                                
                            }
                        }
                    tav2(tabIndex: $tabIndex)
                        .tabItem{
                            Text("Chap. 2")
                        }.tag(2)
                        .onAppear {
                            if HappyMusic?.isPlaying == true{
                                HappyMusic?.stop()
                                
                            }
                            if SadMusic?.isPlaying == false {
                                SadMusic?.setVolume(0, fadeDuration: 0)
                                SadMusic?.play()
                                SadMusic?.setVolume(0.5, fadeDuration: 4)
                                
                                
                            }
                        }
                        
                    tav3(tabIndex: $tabIndex)
                        .tabItem{
                            Text("Chap. 3")
                        }
                        .tag(3)
                        .onAppear {
                            if HappyMusic?.isPlaying == true{
                                HappyMusic?.stop()
                                
                            }
                            if SadMusic?.isPlaying == false {
                                SadMusic?.setVolume(0, fadeDuration: 0)
                                SadMusic?.play()
                                SadMusic?.setVolume(0.5, fadeDuration: 4)
                                
                                
                            }
                        }
                    tav4(tabIndex: $tabIndex)
                        .tabItem {
                            Text("Chap. 4")
                        }
                        .tag(4)
                        .onAppear {
                            if SadMusic?.isPlaying == true{
                                SadMusic?.stop()
                                
                            }
                            HappyMusic?.setVolume(0, fadeDuration: 0)
                            HappyMusic?.currentTime = Double(0)
                           
                            //dopo 5 secondi
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                HappyMusic?.play()

                               

                                HappyMusic?.setVolume(0.25, fadeDuration: 3)

                                
                               }
                        }
                    tav5(tabIndex: $tabIndex)
                        .tabItem {
                            Text("Chap. 5")
                        }
                        .tag(5).onAppear {
                            if SadMusic?.isPlaying == true{
                                SadMusic?.stop()
                                
                            }
                            FlipPage?.play()

                            HappyMusic?.setVolume(0, fadeDuration: 0)
                            HappyMusic?.play()
                            HappyMusic?.currentTime = Double(60)
                            HappyMusic?.setVolume(0.5, fadeDuration: 4)
                        }
                    tav6(tabIndex: $tabIndex)
                        .tabItem {
                            Text("End")
                        }
                        .tag(6).onAppear {
                            if SadMusic?.isPlaying == true{
                                SadMusic?.stop()
                                
                            }
                            FlipPage?.play()

                            HappyMusic?.play()
                            HappyMusic?.currentTime = Double(183)
                            HappyMusic?.setVolume(0.5, fadeDuration: 4)
                        }
                
        }.onReceive(Just(tabIndex)) {
                    print("Tapped!!")
                    FlipPage?.play()
                    
                    switch $0 {
                    case 4:
                        HappyMusic?.setVolume(0, fadeDuration: 0)
                        HappyMusic?.currentTime = Double(0)
                       
                        //dopo 5 secondi
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            HappyMusic?.play()

                           

                            HappyMusic?.setVolume(0.25, fadeDuration: 3)

                            
                           }
                    case 5:
                        HappyMusic?.setVolume(0, fadeDuration: 0)
                        HappyMusic?.play()
                        HappyMusic?.currentTime = Double(60)

                        HappyMusic?.setVolume(0.5, fadeDuration: 4)
                    
                    case 6:
                        HappyMusic?.play()
                        HappyMusic?.currentTime = Double(183)
                        HappyMusic?.setVolume(0.25, fadeDuration: 4)

                    default:
                        HappyMusic?.setVolume(0, fadeDuration: 1)
                    }
                }
        }
    }

struct introView: View {
    @Binding var tabIndex: Int
    @State var animationAmount : Bool = false
    
    struct MyButtonStyle: ButtonStyle {
        public func makeBody(configuration: MyButtonStyle.Configuration) -> some View {
            configuration.label
                .opacity(configuration.isPressed ? 1 : 1)
                .scaleEffect(configuration.isPressed ? 0.8 : 1)
                .frame(width: 200, height: 200, alignment: .center)
        }
    }

    var body: some View {
        VStack{
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Tappami la minchia per continuare")
                .offset(y:+50)
                .padding(20)
                .opacity(animationAmount ? 0 : 1)
            Spacer()
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
                    .frame(width: 100)
                    .opacity(animationAmount ? 0 : 1)
                    
            }.buttonStyle(MyButtonStyle())
                .onAppear(perform: {
                    self.animationAmount = false
                    self.tabIndex = 0
                })
        }
    }
}



struct tav1: View {
    @Binding var tabIndex: Int
    @State private var tav1In = false;
    
    var body: some View {
        VStack{
            HStack{
                Image(uiImage: UIImage(named: "tav1_ombra")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400)
                    .offset(x:-45, y:-2)
                    .overlay(Image(uiImage: UIImage(named: "tav1_depressino")!)
                                .resizable()
                                .offset(x:-80, y:-25)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 500))
                    .opacity(tav1In ? 1 : 0.10)
            }
            HStack() {
                Button(action: {
                    withAnimation(.linear(duration: 1.0)) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.tabIndex += 1
                        }
                    }
                }){
                    Text("Depressino is alone with his thoughs, while around him people happily chat")
                }
            }
            //Spacer(minLength: 5)
            HStack(alignment: .lastTextBaseline){
                Image(uiImage: UIImage(named: "tav1_gruppo")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
                    .opacity(tav1In ? 1 : 0.10)
            }
        }.onAppear(perform: {
            self.tav1In = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: 1)) {
                    self.tav1In = true
                }
            }
        }).opacity(tav1In ? 1 : 0)
    }
}

struct tav2 : View {
    @Binding var tabIndex: Int
    @State private var tav2In = false;
    
    var body: some View {
        VStack{
            HStack{
                Image(uiImage: UIImage(named: "tav2_depressino")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 390)
                    .opacity(tav2In ? 1 : 0.10)
                    
                    
                
                    
                    
                Image(uiImage: UIImage(named: "tav2_lucepsicologo")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                    .offset(x:-45, y:-2)
                    .overlay(Image(uiImage: UIImage(named: "tav2_spicologo")!)
                                .resizable()
                                .offset(x:-80, y:-25)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 400))
                    .opacity(tav2In ? 1 : 0.10)
                    
            }.background(Color.black)
            
        }.onAppear(perform: {
            self.tav2In = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: 1)) {
                    self.tav2In = true
                }
            }
        }).opacity(tav2In ? 1 : 0)
            .background(Color.black)
    }

}

struct tav3: View {
    @Binding var tabIndex: Int
    @State private var tav3In: Bool = false
    @State private var tav3An: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                VStack {
                    Image(uiImage: UIImage(named: "tav3_depressino")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70)
                        .opacity(1)
                        .offset(y:+100)
                    Image(uiImage: UIImage(named: "tav3_balloon")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 110)
                        .opacity(1)
                        .scaleEffect(1.55)
                        .offset(x:-10, y:-75)
                }
                Image(uiImage: UIImage(named: "tav3_lucepsicologo")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 620)
                    .offset(y:+5)
                    .overlay(Image(uiImage: UIImage(named: (tav3An ? "tav2_spicologo" : "tav3_psicologo"))!)
                                .resizable()
                                .offset(x:(tav3An ? 0 : +50))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200))
                    .opacity(tav3In ? 1 : 0.10)
                }
        }.onAppear(perform: {
            self.tav3In = false
            self.tav3An = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: 1)) {
                    self.tav3In = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.spring()) {
                        self.tav3An = true
                    }
                }
            }
        }).opacity(tav3In ? 1 : 0)
            .background(Color.black)
    }
}

struct tav4 : View {
    @Binding var tabIndex: Int
    @State private var tav4In = false;
    
    var body: some View{
        VStack{
            HStack{
                Image(uiImage: UIImage(named: "tav_4")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
            }.opacity(tav4In ? 1 : 0.10)
        }.onAppear(perform: {
            self.tav4In = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: 1)) {
                    self.tav4In = true
                }
            }
        }).opacity(tav4In ? 1 : 0)
    }
}

struct tav5 : View {
    @Binding var tabIndex: Int
    @State private var tav5In = false;
    
    var body: some View{
        VStack{
            HStack{
                Image(uiImage: UIImage(named: "tav_5")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
            }.opacity(tav5In ? 1 : 0.10)
        }.onAppear(perform: {
            self.tav5In = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: 1)) {
                    self.tav5In = true
                }
            }
        }).opacity(tav5In ? 1 : 0)
    }
}

struct tav6 : View {
    @Binding var tabIndex: Int
    @State private var tav6In = false;
        
    var body: some View{
        VStack{
            HStack{
                Image(uiImage: UIImage(named: "tav6_lucetitolo")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400)
                    .overlay(Image(uiImage: UIImage(named: "tav6_titoli")!)
                                .resizable()
                                .offset(x:+30)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 500))

            }.opacity(tav6In ? 1 : 0.10)
        }.onAppear(perform: {
            self.tav6In = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: 1)) {
                    self.tav6In = true
                }
            }
        }).opacity(tav6In ? 1 : 0)
    }
}



PlaygroundSupport.PlaygroundPage.current.setLiveView(myView());
