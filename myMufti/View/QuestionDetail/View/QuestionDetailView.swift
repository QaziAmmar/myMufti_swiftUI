//
//  QuestionDetailView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 01/07/2022.
//

import SwiftUI

struct QuestionDetailView: View {
    
    
    @StateObject var vm = HomeViewModel()
    @State private var date = Date()
    @State private var tabSelection_userId = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            bgGradient()
            loadView()
        }.alert(isPresented: $vm.showError, content: {
            Alert(title: Text(vm.errorMessage))
        })
        .onAppear {
            vm.getAllMuftiesApi()
        }
        
        
    }
}

extension QuestionDetailView  {
    
    func bgGradient() -> some View {
        LinearGradient(colors: [Color.init(hex: "74A886"), Color.init(hex: "24452F")], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
    
    func loadView() -> some View {
       
        
        VStack {
            homeNav()
            bannerView()
            postQuestion()
            
            
            TabView(selection: $tabSelection_userId) {

                ForEach($vm.questions) { question in
                    QuestionCardView(question: question)
                        .padding()
                        .onTapGesture {
                            print("did tapped")
                        }
                }
                    
            } //: TabView
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            
            GreenBtn(action: {
                print("see all btn")
            }, title: "See All")
            .padding()
        }
    }
}




// MARK: - ViewExtension
extension QuestionDetailView {
    
    func homeNav() -> some View {
        HStack {
            Spacer()
            Text("Home")
                .foregroundColor(.white)
                .font(.custom(Popins.bold.rawValue, size: 18))
                .offset(x: 60)
            Spacer()
            HStack {
                Text("Are you a scholar?")
                    .foregroundColor(.white)
                    .font(.custom(Popins.regular.rawValue, size: 7))
                
                
                NavigationLink {
                    Text("Join us")
                } label: {
                    Text("join us")
                        .foregroundColor(Color(ColorName.appGreen.rawValue))
                        .font(.custom(Popins.regular.rawValue, size: 7))
                        .padding([.leading, .trailing], 10)
                        .padding([.bottom, .top], 7)
                        .background(
                            RoundedCorner(radius: 7)
                                .foregroundColor(.white)
                        )
                }
            }
        }
        .padding()
    }
    
    func bannerView() -> some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 5){
                Text("Personal Questions or Problem?")
                    .font(.custom(Popins.bold.rawValue, size: 18))
                Text("Ask mufti personaly and book an appointment.")
                    .font(.custom(Popins.regular.rawValue, size: 14))
                
                NavigationLink {
                    Text("Ask Mufti Now")
                } label: {
                    Text("Ask Mufti Now")
                        .padding(10)
                        .foregroundColor(Color.init(hex: "C7F9C5"))
                        .font(.custom(Popins.bold.rawValue, size: 14))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.init(hex: "154A14"))
                        )
                }

            }.padding([.leading])
            Image(ImageName.banner.rawValue)
                .resizable()
                .frame(width: 153, height: 153)
        }.background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.init(hex: "C7F9C5"))
        )
    }
    
    func postQuestion() -> some View {
        HStack {
            
            Text("Questions")
                .foregroundColor(.white)
                .font(.custom(Popins.semiBold.rawValue, size: 24))
            Spacer()
            
            NavigationLink {
                Text("Post a Question")
            } label: {
                Text("Post a Question")
                    .foregroundColor(Color(ColorName.appGreen.rawValue))
                    .font(.custom(Popins.bold.rawValue, size: 10))
                    .padding([.leading, .trailing], 10)
                    .padding([.bottom, .top], 7)
                    .background(
                        RoundedCorner(radius: 7)
                            .foregroundColor(.white)
                    )
            }
            
        }
        .padding()
    }
    
}



struct QuestionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionDetailView()
    }
}
