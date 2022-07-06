//
//  WhiteQuestionCardView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 06/07/2022.
//

import SwiftUI



struct WhiteQuestionCardView: View {
    
    var question: QuestionModel
    
    var body: some View {
        ZStack {
            
            loadView()
                .background(
                    Rectangle()
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 3)
                )
            
        }
    }
}


extension WhiteQuestionCardView {
    func loadView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            userNameView()
            
            Text(question.question)
                .lineLimit(3)
                .font(.custom(Popins.regular.rawValue, size: 15))
            
            percentageView()
            
            commentSection()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
            
        )
    }
    
    func userNameView() -> some View {
        HStack {
            
            AsyncImageMLB(url: URL(string: question.userID.image ?? ""))
                .frame(width: 50, height: 50)
                .cornerRadius(25)
            
            
            Text(question.userID.name ?? "")
                .font(.custom(Popins.semiBold.rawValue, size: 13))
            
            
            Spacer()
            
            Text(question.createAgo)
                .font(.custom(Popins.regular.rawValue, size: 11))
            
        }
    }
    
    func percentageView() -> some View {
        
        HStack {
            Spacer()
            ZStack(alignment: .bottom) {
                
                ZStack{
                    ZStack {
                        Circle()
                            .trim(from: 0, to: 0.75)
                            .rotation(Angle(degrees: 135))
                            .stroke(.gray, lineWidth: 3)
                            .frame(width: 100, height: 100)
                        Circle()
                            .trim(from: 0, to: question.yesNormilized)
                            .rotation(Angle(degrees: 135))
                            .stroke(.green, lineWidth: 4)
                            .frame(width: 100, height: 100)
                    }
                    
                    Text(question.yesPercentage).foregroundColor(.gray)
                        .font(.custom(Popins.semiBold.rawValue, size: 18))
                    
                }
                Text("Yes")
                    .foregroundColor(.gray)
                    .font(.custom(Popins.regular.rawValue, size: 13))
                    .padding([.leading, .trailing], 17)
                    .padding([.bottom, .top], 1)
                
                    .offset(y: 5)
                
            }
            Spacer(minLength: 50)
            ZStack(alignment: .bottom) {
                
                ZStack{
                    ZStack {
                        Circle()
                            .trim(from: 0, to: 0.75)
                            .rotation(Angle(degrees: 135))
                            .stroke(.gray, lineWidth: 3)
                            .frame(width: 100, height: 100)
                        Circle()
                            .trim(from: 0, to: question.noNormilized)
                            .rotation(Angle(degrees: 135))
                            .stroke(.green, lineWidth: 4)
                            .frame(width: 100, height: 100)
                    }
                    
                    Text(question.noPercentage).foregroundColor(.gray)
                        .font(.custom(Popins.semiBold.rawValue, size: 18))
                    
                }
                
                Text("No")
                    .foregroundColor(.gray)
                    .font(.custom(Popins.regular.rawValue, size: 13))
                    .padding([.leading, .trailing], 17)
                    .padding([.bottom, .top], 1)
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
            
            Spacer()
        }
        .padding(.top)
    }
    
    
}


struct WhiteQuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        WhiteQuestionCardView(question: QuestionModel(questionID: "", userID: UserID(image: "", id: "", name: ""), questionTitle: "", question: "", options: "", timeLimit: "", createdAt: "", userVote: "", muftiAnswer: "", questionCategories: [], questionComment: 5, totalVote: 5, totalVoteForYes: 5, totalVoteForNo: 5))
    }
}
