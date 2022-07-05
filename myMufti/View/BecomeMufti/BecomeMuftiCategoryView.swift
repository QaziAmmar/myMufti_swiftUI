//
//  BecomeMuftiCategoryView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 04/07/2022.
//

import SwiftUI

struct BecomeMuftiCategoryView: View {
    
    @StateObject var vm = BecomeMuftiViewModel()
    
    var name = ""
    var phone = ""
    var degreeName = ""
    var degreestartDate = ""
    var degreeendDate = ""
    var instituteName = ""
    var experienceFrom = ""
    var experienceTo = ""
    var degreeimage = UIImage()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        loadViw()
            .alert(isPresented: $vm.showError, content: {
            Alert(title: Text(vm.errorMessage))
        })
            .onAppear {
                vm.populateData(name: name, phone: phone, degreeName: degreeName, degreestartDate: degreestartDate, degreeendDate: degreeendDate, instituteName: instituteName, experienceFrom: experienceFrom, experienceTo: experienceTo, degreeimage: getBase64String(from: degreeimage))
            }
    }
}


// MARK: - View Extension
extension BecomeMuftiCategoryView {
    
    func loadViw() -> some View {
        VStack {
            
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, titile: "Become a Mufti")
            
            
            VStack () {
                
                Image(ImageName.categoryProgress.rawValue)
                    .resizable()
                    .frame(height: 25)
                    .padding([.bottom])
                
                HStack {
                    Image(ImageName.actionImage.rawValue)
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Text("Please select your fields of interest")
                        .foregroundColor(.gray)
                        .font(.custom(Popins.regular.rawValue, size: 10))
                    Spacer()
                }.padding([.bottom])
                
                ScrollView {
                    LazyVStack {
                       
                        ForEach($vm.categories) { category in
                            CategoryRow(category: category)
                        }
                        
                    }
                }.padding(.bottom)
                
                GreenBtn(action: {
                    vm.callBecomeMuftiAPI()
                }, title: "Submit")
                
                hiddenView()
            }.padding()
            
        }
    }
    
    
    func hiddenView() -> some View {
        NavigationLink(destination: HideNavbarOf(view: BecomeMuftiSuccessView()) , isActive: $vm.moveToSuccess) {
            EmptyView()
        }.hidden()
    }
    
}

struct BecomeMuftiCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        BecomeMuftiCategoryView()
    }
}
