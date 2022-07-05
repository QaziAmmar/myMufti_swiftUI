//
//  HomeView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 20/06/2022.
//


/// start developing the card view
import SwiftUI

struct HomeView: View {
    
    
    @StateObject var vm = HomeViewModel()
    @State private var date = Date()
    @State private var tabSelection_userId = 0
    @State private var movetoBecomeMufti = false
    
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
        .onReceive(UserDefaultManager.muftiSuccess, perform: { newValue in
            movetoBecomeMufti = newValue
        })
    }
}

extension HomeView  {
    
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
                    NavigationLink {
                        HideNavbarOf(view: QuestionCommentView(question: question))
                    } label: {
                        QuestionCardView(question: question)
                            .padding()
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
extension HomeView {
    
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
                
                NavigationLink(isActive: $movetoBecomeMufti) {
                    HideNavbarOf(view: BecomeMuftiPersonInfoView())
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
                
                
                Button {
                    UserDefaultManager.changeTab.send(1)
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
                HideNavbarOf(view: PostQuestionView())
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



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
