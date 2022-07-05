//
//  QuestionCardView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 30/06/2022.
//

import SwiftUI

struct QuestionCardView: View {
    
    @Binding var question: QuestionModel
    
    var body: some View {
        ZStack {
            loadView()
        }
    }
}


extension QuestionCardView {
    func loadView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            userNameView()
            
            Text(question.question)
                .lineLimit(3)
                .foregroundColor(.white)
                .font(.custom(Popins.regular.rawValue, size: 15))
            
            percentageView()
            
            commentSection()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .opacity(0.2)
        )
    }
    
    func userNameView() -> some View {
        HStack {
            
            AsyncImageMLB(url: URL(string: question.userID.image ?? ""))
                .frame(width: 50, height: 50)
                .cornerRadius(25)
            
                
            Text(question.userID.name ?? "")
                .font(.custom(Popins.semiBold.rawValue, size: 13))
                .foregroundColor(.white)
            
            Spacer()
            
            Text(question.createAgo)
                .font(.custom(Popins.regular.rawValue, size: 11))
                .foregroundColor(.white)
        }
    }
    
    func percentageView() -> some View {
        
        HStack {
            Spacer()
            ZStack(alignment: .bottom) {
                
                ZStack{
                    Circle()
                        .trim(from: 0, to: 0.75)
                        .rotation(Angle(degrees: 135))
                        .stroke(.white, lineWidth: 3)
                        .frame(width: 100, height: 100)
                    Text(question.yesPercentage).foregroundColor(.white)
                        .font(.custom(Popins.semiBold.rawValue, size: 18))
                    
                }
                
//                Button {
//                    print("hellow")
//                } label: {
//
//
//                }
                Text("Yes")
                    .foregroundColor(.white)
                    .font(.custom(Popins.regular.rawValue, size: 13))
                    .padding([.leading, .trailing], 17)
                    .padding([.bottom, .top], 1)
                    .background(
                        RoundedCorner(radius: 7)
                            .foregroundColor(Color(ColorName.appGreen.rawValue))
                    )
                .offset(y: 5)
                
            }
            Spacer(minLength: 50)
            ZStack(alignment: .bottom) {
                
                ZStack{
                    Circle()
                        .trim(from: 0, to: 0.75)
                        .rotation(Angle(degrees: 135))
                        .stroke(.white, lineWidth: 3)
                        .frame(width: 100, height: 100)
                    Text(question.noPercentage).foregroundColor(.white)
                        .font(.custom(Popins.semiBold.rawValue, size: 18))
                    
                }
                
//                Button {
//                    print("hellow")
//                } label: {
//
//                }
                
                Text("No")
                    .foregroundColor(.white)
                    .font(.custom(Popins.regular.rawValue, size: 13))
                    .padding([.leading, .trailing], 17)
                    .padding([.bottom, .top], 1)
                    .background(
                        RoundedCorner(radius: 7)
                            .foregroundColor(Color(ColorName.appLightGray.rawValue))
                    )
                .offset(y: 5)
                
            }
            
            
            Spacer()
        }
    }
    
    func commentSection() -> some View {
        HStack {
         Spacer()
            HStack(spacing: 10) {
                VStack {
                    Text("Remaining Time")
                    Text(question.timeRemaining)
                }
                
                Rectangle()
                    .frame(width: 2, height: 40)
                
                VStack {
                    Text("Comments")
                    Text("\(question.questionComment)")
                }
                
                Rectangle()
                    .frame(width: 2, height: 40)
                    

                VStack {
                    Text("Votes")
                    Text("\(question.totalVote)")
                }
            }
            .font(.custom(Popins.regular.rawValue, size: 14))
        .foregroundColor(.white)
            Spacer()
        }
        .padding(.top)
    }
    
    
}

struct QuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCardView(question: .constant(QuestionModel(questionID: "", userID: UserID(image: "", id: "", name: ""), questionTitle: "", question: "", options: "", timeLimit: "", createdAt: "", userVote: "", muftiAnswer: "", questionCategories: [], questionComment: 5, totalVote: 5, totalVoteForYes: 5, totalVoteForNo: 5)))
    }
}
