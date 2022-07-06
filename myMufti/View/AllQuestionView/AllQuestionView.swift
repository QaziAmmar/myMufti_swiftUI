//
//  AllQuestionView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 06/07/2022.
//

import SwiftUI

struct AllQuestionView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var questions = [QuestionModel]()
    
    
    var body: some View {
        loadView()
    }
}

// MARK: - View Extension
extension AllQuestionView {
    
    
    func loadView() -> some View {
        VStack {
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, titile: "Questions")
            
            VStack {
                ScrollView{
                    if questions.count == 0 {
                        Text("No Question")
                            .font(.custom(Popins.bold.rawValue, size: 20))
                    } else {
                        ForEach(questions) { question in
                            WhiteQuestionCardView(question: question)
                                .padding()
                        }
                        
                    }
                }
            }
        }
    }
    
    
}

struct AllQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        AllQuestionView()
    }
}
