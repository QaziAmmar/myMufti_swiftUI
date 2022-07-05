//
//  BecomeMuftiEduView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 04/07/2022.
//

enum DateSelectedType {
    case degreeFrom
    case degreeTo
    case experienceFrom
    case experienceTo
    
}

import SwiftUI

struct BecomeMuftiEduView: View {
    
    @State private var showError = false
    @State private var errorMessage = ""
    
    var name = ""
    var phone = ""
    
    @State private var degreeName = ""
    @State private var degreestartDate = ""
    @State private var degreeendDate = ""
    @State private var instituteName = ""
    @State private var experienceFrom = ""
    @State private var experienceTo = ""
    
    @State private var degreeimage = UIImage()
    
    @State private var showDatePicker = false
    @State private var showImagePicker = false
    
    @State private var dateselectedField: DateSelectedType = .degreeFrom
    
    @State private var isActiveMoveToCategoryView = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        loadViewWithDatePicker()
            .alert(isPresented: $showError, content: {
                Alert(title: Text(errorMessage))
            })
            .sheet(isPresented: $showImagePicker, content: {
                ImagePickerView(sourceType: .photoLibrary) { image in
                    self.degreeimage = image
                }
            })
    }
}

// MARK: - View Extension
extension BecomeMuftiEduView  {
    
    
    func loadViewWithDatePicker() -> some View {
        ZStack {
            loadView()
            
            if showDatePicker {
                DatePickerMLB(showDatePicker: $showDatePicker, displayedComponents: [.date]) {  data in

                    switch dateselectedField {
                    case .degreeFrom:
                        degreestartDate = DateManager.standard.getString(from: data)
                    case .degreeTo:
                        degreeendDate = DateManager.standard.getString(from: data)
                    case .experienceFrom:
                        experienceFrom = DateManager.standard.getString(from: data)
                    case .experienceTo:
                        experienceTo = DateManager.standard.getString(from: data)
                    }
                    
                    showDatePicker.toggle()
                }
            }
        }
    }
    
    
    func loadView() -> some View {
        VStack {
            NavBar(action: {
                presentationMode.wrappedValue.dismiss()
            }, titile: "Become Mufti")
            
            VStack (){
                
                Image(ImageName.eduProgress.rawValue)
                    .resizable()
                    .frame(height: 30)
                    .padding([.bottom])
                
                HStack {
                    Image(ImageName.actionImage.rawValue)
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Text("Please fill following information")
                        .foregroundColor(.gray)
                        .font(.custom(Popins.regular.rawValue, size: 10))
                    Spacer()
                }.padding([.bottom])
                
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Name")
                        .foregroundColor(.gray)
                    
                    
                    ZStack(alignment: .trailing) {
                        CustomTextField(placeHolder: "Degree Name", text: $degreeName, isSecure: false)
                            .shadow(color: .gray, radius: 2)
                        
                        Button {
                            showImagePicker.toggle()
                        } label: {
                            Image(ImageName.documetns.rawValue)
                                .resizable()
                                .frame(width: 14, height: 24)
                        }.padding()
                        
                    }
                    
                }
                
                HStack(spacing: 20) {
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Start Date")
                            .foregroundColor(.gray)
                        
                        
                        ActionableTextField(placeHolder: "From", text: $degreestartDate) {
                            showDatePicker = true
                            dateselectedField = .degreeFrom
                        }.shadow(color: .gray, radius: 2)
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("End Date")
                            .foregroundColor(.gray)
                        
                        ActionableTextField(placeHolder: "To", text: $degreeendDate) {
                            showDatePicker = true
                            dateselectedField = .degreeTo
                        }.shadow(color: .gray, radius: 2)
                        
                    }
                    
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Institute Name")
                        .foregroundColor(.gray)
                    
                    CustomTextField(placeHolder: "Institute Name", text: $instituteName, isSecure: false)
                        .shadow(color: .gray, radius: 2)
                    
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Experience")
                        .foregroundColor(.gray)
                    
                    ActionableTextField(placeHolder: "From", text: $experienceFrom) {
                        showDatePicker = true
                        dateselectedField = .experienceFrom
                    }.shadow(color: .gray, radius: 2)
                    
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Experience")
                        .foregroundColor(.gray)
                    
                    ActionableTextField(placeHolder: "To", text: $experienceTo) {
                        showDatePicker = true
                        dateselectedField = .experienceTo
                    }.shadow(color: .gray, radius: 2)
                    
                }
                
                hiddenView()
                
                Spacer()
                
                
                GreenBtn(action: {
                    self.moveToEducationVew()
                }, title: "Next").padding(.top)
                
            }.padding()
        }
        
    }
    
    
    func hiddenView() -> some View {
        NavigationLink(destination: HideNavbarOf(view: BecomeMuftiCategoryView(name: name, phone: phone, degreeName: degreeName, degreestartDate: degreestartDate, degreeendDate: degreeendDate, instituteName: instituteName, experienceFrom: experienceFrom, experienceTo: experienceTo, degreeimage: degreeimage)), isActive: $isActiveMoveToCategoryView) {
            EmptyView()
        }.hidden()
    }
    
}


extension BecomeMuftiEduView {
    
    // Move to education View
    func moveToEducationVew()  {
        if validationCheck() {
            isActiveMoveToCategoryView = true
        }
    }
    
    // Move to validation Check View
    func validationCheck() -> Bool {
        if degreeName.isEmpty {
            showError = true
            errorMessage = "Please enter Degree Name"
            return false
        }
        
        // check to find either image is empty of not
        let cgref = degreeimage.cgImage
        let cim = degreeimage.ciImage

        if cim == nil && cgref == nil {
            errorMessage = "Please select Degree Image"
            showError = true
            return false
        }
        
        
        
        if degreestartDate.isEmpty {
            showError = true
            errorMessage = "Please enter Degree Start Date"
            return false
        }
        
        if degreeendDate.isEmpty {
            showError = true
            errorMessage = "Please enter Degree end Date"
            return false
        }
        if instituteName.isEmpty {
            showError = true
            errorMessage = "Please enter your Institute Name"
            return false
        }
        if experienceFrom.isEmpty {
            showError = true
            errorMessage = "Please enter experience start date"
            return false
        }
        if experienceTo.isEmpty {
            showError = true
            errorMessage = "Please enter experience end date"
            return false
        }
        
        
        return true
        
    }
    
}
struct BecomeMuftiEduView_Previews: PreviewProvider {
    static var previews: some View {
        BecomeMuftiEduView()
    }
}
