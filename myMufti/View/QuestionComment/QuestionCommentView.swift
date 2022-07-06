//
//  QuestionComment.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 05/07/2022.
//

import SwiftUI

struct QuestionCommentView: View {
    
    @StateObject var vm = QuestionCommentViewModel()
    @State private var isSharePresented = false
    @Binding var question: QuestionModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            bgGradient()
            loadView()
        }.alert(isPresented: $vm.showError, content: {
            Alert(title: Text(vm.errorMessage))
        }).onAppear {
            vm.getCommentsOf(question_id: question.questionID)
        }
        .sheet(isPresented: $isSharePresented, onDismiss: {
            print("Dismiss")
        }, content: {
            ActivityViewController(activityItems: [question.questionTitle, question.question])
        })
        
    }
}

extension QuestionCommentView  {
    
    func bgGradient() -> some View {
        LinearGradient(colors: [Color.init(hex: "74A886"), Color.init(hex: "24452F")], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
    
    func loadView() -> some View {
       
        
        VStack {
            
            questionNav()
            
            
            VStack(spacing: 0) {
                QuestionCardView(question: $question, action: {_ in })
                remainingTimeView()
                
            }
            
            if question.openToAnswer ?? true {
                muftiAnswerView()
            }

            Spacer()
            
            VStack(spacing: 0) {
                seeAllcomment()
                commentList()
                commentBtn()
            }
        }
    }
}




// MARK: - ViewExtension
extension QuestionCommentView {
    
    func questionNav() -> some View {
        HStack {
            
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(ImageName.quesBackBtn.rawValue)
                    .resizable()
                    .frame(width: 25, height: 25)
            }

            
            
            Spacer()
            Text("Question")
                .foregroundColor(.white)
                .font(.custom(Popins.bold.rawValue, size: 18))
                .offset(x: 13)
            Spacer()
            
            Button {
                isSharePresented.toggle()
            } label: {
                Image(ImageName.shareBtn.rawValue)
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            
        }
        .padding()
    }
    
    func remainingTimeView() -> some View {
        HStack {
            
            Text("50K Votes")
                .font(.system(size: 12, weight: .medium, design: .default))
            
            Spacer()
            
            HStack {
                Text("Remaining Time")
                    .font(.system(size: 10, weight: .medium, design: .default))

                Text("45 min")
                    .font(.system(size: 12, weight: .medium, design: .default))
            }
            
        }.foregroundColor(.white)
            .padding()
    }
    
    func muftiAnswerView() -> some View {
        HStack(spacing: 0) {
            
            CustomTextField(placeHolder: "Mufti's Answer", text: $vm.muftiAnswer, isSecure: false)
                .padding([.leading, .trailing])
            
            // show send button only when the user press the send button.
            if !vm.muftiAnswer.isEmpty {
                Button {
                    // submit mufti answer to the server
                    vm.muftiAnswer(question_id: question.questionID) {
                        question.openToAnswer = false
                    }
                    
                } label: {
                    Image(ImageName.commentBtn.rawValue)
                        .resizable()
                        .frame(width: 45, height: 45)
                }.transition(.scale)
                    .padding([.trailing])
            }
        }
    }
    
    func seeAllcomment() -> some View {
        VStack {
            
            HStack {
                Text("Comments")
                    .font(.custom(Popins.semiBold.rawValue, size: 14))
                
                Spacer()

                if vm.comments.count != 0 {
                    NavigationLink {
                        HideNavbarOf(view: SeeAllCommentsView(comments: vm.comments))
                    } label: {
                        HStack {
                            Text("See All")
                                .font(.custom(Popins.semiBold.rawValue, size: 14))
                            Image(ImageName.next_white.rawValue)
                                .resizable()
                                .frame(width: 9, height: 15)
                        }
                    }
                }

            }.foregroundColor(.white)
            
        }.padding()
    }
    
    func commentList() -> some View {
        
        ScrollViewReader { scrollView in
            ScrollView(.vertical ,showsIndicators : false) {
                    ForEach(vm.comments.indices, id: \.self) { index in
                        CommentRow(comment: vm.comments[index])
                            .id(index)
                    }
                    
            }.onChange(of: vm.comments.count) { count in
                withAnimation {
                    scrollView.scrollTo(vm.comments.count - 1)
                }
            }
            
        }.padding()
        
        
    }
    
    func commentBtn() -> some View {
        HStack {
            // Start Description View
            ZStack(alignment: .topLeading) {
                
                if vm.userComment.isEmpty {
                    Text("Add a Comment")
                        .foregroundColor(.gray)
                        .padding()
                }
                
                TextField("", text: $vm.userComment)
                    .font(.custom(Popins.regular.rawValue, size: 16))
                    .frame(height: 35)
                    .opacity(vm.userComment.isEmpty ? 0.1 : 1)
                    .foregroundColor(.white)
                    .padding()
            }
            .font(.custom(Popins.regular.rawValue, size: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.white, lineWidth: 2)
                    .frame(height: 45)
            )
            
            
            Button {
                vm.postCommentApi(question_id: question.questionID)
            } label: {
                Image(ImageName.commentBtn.rawValue)
                    .resizable()
                    .frame(width: 45, height: 45)
            }

            
        }.padding([.leading, .trailing])
    }
    
    
    // UIActivity Controller
    
}


struct QuestionComment_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCommentView(question: .constant(QuestionModel(questionID: "", userID: UserID(image: "", id: "", name: ""), questionTitle: "", question: "", options: "", timeLimit: "", createdAt: "", userVote: "", muftiAnswer: "", questionCategories: [], questionComment: 1, totalVote: 1, totalVoteForYes: 1, totalVoteForNo: 1)))
    }
}
