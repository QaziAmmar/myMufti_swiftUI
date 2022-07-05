//
//  PostQuestionView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 04/07/2022.
//

import SwiftUI

enum VotingOption: Int {
    case option1 = 1
    case option2 = 2
    case none = 0
}


// Make a view remaing view for the bototm sectoin

struct PostQuestionView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var vm = PostQuestionViewModel()
    
    
    @State private var showUserInfo = true
    @State private var movetoCategories = false
    @State private var showDatePicker = false
    

    
    var body: some View {
        
        ZStack {
        
            loadView()
            
            if showDatePicker {
                pickerView()
                }
            
            }.alert(isPresented: $vm.showError, content: {
                Alert(title: Text(vm.errorMessage))
            }).onReceive(vm.$moveToSuccess) { success in
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        
        
    }


// MARK: - UIView Extension
extension PostQuestionView {
    
    func loadView() -> some View {
        VStack {
            
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, titile: "Ask a Question")
            
            
            VStack(alignment: .leading) {
                
                questionDetailView()
                votingOptionView()
                hideUserInfoView()
                moveToNextView()
                
                Spacer()
                hiddenView()
                
                GreenBtn(action: {
                    vm.postQuestion()
                }, title: "Submit Question")
                
            }.padding()
            
            
            
        }
    }
    
    func questionDetailView() -> some View {
        VStack(alignment: .leading) {
            Text("Question")
                .foregroundColor(.gray)
                .font(.system(size: 14))
            
            ZStack(alignment: .topLeading) {
                
                if vm.question_detail.isEmpty {
                    Text("Write your question here")
                        .foregroundColor(.gray)
                        .padding()
                }
                
                TextEditor(text: $vm.question_detail)
                    .font(.custom(Popins.regular.rawValue, size: 15))
                    .frame(height: 75)
                    .opacity(vm.question_detail.isEmpty ? 0.1 : 1)
            }
            .font(.custom(Popins.regular.rawValue, size: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 8).stroke(.gray)
            )
        }
    }

    func votingOptionView() -> some View {
        VStack(alignment: .leading) {
            Text("Select option for voting")
                .foregroundColor(.gray)
                .font(.system(size: 14))
            
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    vm.votingOption = .option1
                } label: {
                    HStack {
                        Image(vm.votingOption == .option1 ? ImageName.radio_checked.rawValue : ImageName.radio_unchecked.rawValue)
                        Text("option 1")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                    
                }.padding([.top, .trailing, .bottom])
                
                
                HStack {
                    Spacer()
                    Text("Yes")
                        .foregroundColor(.white)
                        .font(.custom(Popins.regular.rawValue, size: 16))
                        .padding([.leading, .trailing], 20)
                        .padding([.bottom, .top], 1)
                        .background(
                            RoundedCorner(radius: 7)
                                .foregroundColor(Color(ColorName.appGrayGreen.rawValue))
                        )
                    Spacer()
                    Text("No")
                        .foregroundColor(.white)
                        .font(.custom(Popins.regular.rawValue, size: 16))
                        .padding([.leading, .trailing], 20)
                        .padding([.bottom, .top], 1)
                        .background(
                            RoundedCorner(radius: 7)
                                .foregroundColor(Color(ColorName.appGrayGreen.rawValue))
                        )
                    Spacer()
                }
            }
            
            
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    vm.votingOption = .option2
                } label: {
                    HStack {
                        Image(vm.votingOption == .option2 ? ImageName.radio_checked.rawValue : ImageName.radio_unchecked.rawValue)
                        Text("option 2")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                    
                }.padding([.top, .trailing, .bottom])
                
                
                HStack {
                    Spacer()
                    Text("True")
                        .foregroundColor(.white)
                        .font(.custom(Popins.regular.rawValue, size: 16))
                        .padding([.leading, .trailing], 13)
                        .padding([.bottom, .top], 1)
                        .background(
                            RoundedCorner(radius: 7)
                                .foregroundColor(Color(ColorName.appGrayGreen.rawValue))
                        )
                    Spacer()
                    Text("False")
                        .foregroundColor(.white)
                        .font(.custom(Popins.regular.rawValue, size: 16))
                        .padding([.leading, .trailing], 13)
                        .padding([.bottom, .top], 1)
                        .background(
                            RoundedCorner(radius: 7)
                                .foregroundColor(Color(ColorName.appGrayGreen.rawValue))
                        )
                    Spacer()
                }
            }
            
        }
    }
    
    func hideUserInfoView() -> some View {
        HStack {
            
            Text("Hide user info")
                .foregroundColor(.gray)
                .font(.system(size: 14))
            
            Spacer()
            
            Toggle("", isOn: $showUserInfo)
                .toggleStyle(SwitchToggleStyle(tint: Color(ColorName.appGrayGreen.rawValue)))
        }.padding(.top)
    }
    
    
    func moveToNextView() -> some View {
        VStack {
            
            MovetoNextRow(name: "Categories", image: ImageName.next.rawValue) {
                movetoCategories = true
            }

            MovetoNextRow(name: "Time Limit", image: ImageName.next.rawValue) {
                showDatePicker = true
            }
        }.padding(.top)
    }
    
    
    func pickerView() -> some View {
        
        
        ZStack {
            
            Color.black.opacity(0.2)
                .ignoresSafeArea()
            
            VStack() {
        
                HStack {
                    Spacer()
                    Text("hr")
                    Spacer()
                    Text("min")
                    Spacer()
                    Text("sec")
                    Spacer()
                }.padding(.top)
                
                TimeLimitPicker(data: vm.data, selections: self.$vm.selections)
                
                
                Button {
                    showDatePicker = false
                } label: {
                    Image(systemName: "multiply.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(ColorName.appGrayGreen.rawValue))
                }.padding()
                    
                
                
            }.background(
                Color.white.cornerRadius(10)
                    .padding([.leading, .trailing])
            )
        } //VStack
    }
    
    
    func hiddenView() -> some View {
        VStack {
            
            NavigationLink(isActive: $movetoCategories) {
                HideNavbarOf(view: CategoryListView(vm: vm))
            } label: {
                EmptyView()
            }

            
        }.hidden()
    }
    
    
    
}

struct PostQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        PostQuestionView()
    }
}
