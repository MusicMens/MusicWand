//
//  AboutView.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/01.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
            ScrollView{
                ZStack{
                    VStack(alignment: .center){
                    Text("Music Wand Team")
                       .font(.custom("Chalkduster", size: 45))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 30.0)
                        .frame(width: 400.0)
                    HStack(alignment: .center, spacing: 23.0){
                        VStack {
                            HStack{
                                Image("githubLogo")
                                    .resizable()
                                    .frame(width: 27, height: 27)
                                    .onTapGesture {
                                        let url = URL.init(string: "https://github.com/austingmhuang")
                                        guard let gitURL = url, UIApplication.shared.canOpenURL(gitURL) else { return }
                                        UIApplication.shared.open(gitURL)
                                    }
                                Text("Austin").font(.system(size: 25)).fontWeight(.bold).foregroundColor(Color.white)
                                    .onTapGesture {
                                        let url = URL.init(string: "https://github.com/austingmhuang")
                                        guard let gitURL = url, UIApplication.shared.canOpenURL(gitURL) else { return }
                                    UIApplication.shared.open(gitURL)
                                }
                            }
                            Image("austin")  .resizable().padding(0.0).frame(width: 140, height: 140).cornerRadius(10).shadow(radius: 10)
                        }.padding()
                        VStack {
                            HStack{
                                Image("githubLogo")
                                    .resizable()
                                    .frame(width: 27, height: 27)
                                    
                                Text("Mattia").font(.system(size: 25)).fontWeight(.bold).foregroundColor(Color.white)
                                    .onTapGesture {
                                        let url = URL.init(string: "https://github.com/matt185")
                                        guard let gitURL = url, UIApplication.shared.canOpenURL(gitURL) else { return }
                                        UIApplication.shared.open(gitURL)
                                    }
                                }
                            Image("mattia").resizable().frame(width: 140, height: 140).cornerRadius(10).shadow(radius: 10)
                        }.padding()
                        
}
                    HStack{
                        
                        VStack {
                            HStack{
                                Image("githubLogo")
                                .resizable()
                                .frame(width: 27, height: 27)
                                .onTapGesture {
                                    let url = URL.init(string: "https://github.com/minierparedes")
                                    guard let gitURL = url, UIApplication.shared.canOpenURL(gitURL) else { return }
                                    UIApplication.shared.open(gitURL)
                                }
                                Text("Jesus") .font(.system(size: 25)).fontWeight(.bold).foregroundColor(Color.white)
                                .onTapGesture {
                                    let url = URL.init(string: "https://github.com/minierparedes")
                                    guard let gitURL = url, UIApplication.shared.canOpenURL(gitURL) else { return }
                                    UIApplication.shared.open(gitURL)
                                }
                            }
                            Image("jesus").resizable().frame(width: 140, height: 140).cornerRadius(10).shadow(radius: 10)
                            
                        }.padding()
                        VStack {
                            HStack{
                               Image("githubLogo")
                                .resizable()
                                .frame(width: 27, height: 27)
                                .onTapGesture {
                                    let url = URL.init(string: "https://github.com/scottjohnson623")
                                    guard let gitURL = url, UIApplication.shared.canOpenURL(gitURL) else { return }
                                    UIApplication.shared.open(gitURL)
                                }
                                Text("Scott").font(.system(size: 25)).fontWeight(.bold).foregroundColor(Color.white)
                                .onTapGesture {
                                    let url = URL.init(string: "https://github.com/scottjohnson623")
                                    guard let gitURL = url, UIApplication.shared.canOpenURL(gitURL) else { return }
                                    UIApplication.shared.open(gitURL)
                                }
                            }
                            
                            Image("scott").resizable().frame(width: 140, height: 140).cornerRadius(10).shadow(radius: 10)
                        }.padding()
                        
                    }
                    .font(.body)
                }.padding()
            }
                
          }.background(LinearGradient(gradient: Gradient(colors: [.myPurple, .lightPurple, .veryLightPurple]), startPoint: .top, endPoint: .bottom)).edgesIgnoringSafeArea(.all)
        }
    }


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

extension Color {
    public static var brokenWhite: Color {
        return Color(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 238.0 / 255.0)
    }

    public static var darkGray: Color {
        return Color(red: 57.0 / 255.0, green: 62.0 / 255.0, blue: 70.0 / 255.0)
    }
//    public static var myPurple: Color {
//           return Color(red: 149 / 255.0, green: 56 / 255.0, blue: 183 / 255.0)
//       }
//
//    public static var lightPurple: Color {
//       return Color(red: 202 / 255.0, green: 71 / 255.0, blue: 248 / 255.0)
//    }
//    public static var veryLightPurple: Color {
//       return Color(red: 213 / 255.0, green: 136 / 255.0, blue: 241 / 255.0)
//    }
    public static var myPurple: Color {
           return Color(red: 85 / 255.0, green: 37 / 255.0, blue: 134 / 255.0)
       }

    public static var lightPurple: Color {
       return Color(red: 128 / 255.0, green: 79 / 255.0, blue: 179 / 255.0)
    }
    public static var veryLightPurple: Color {
          return Color(red: 181 / 255.0, green: 137 / 255.0, blue: 214 / 255.0)
       }
}
