//
//  FilterView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 27/06/2022.
//

import SwiftUI


struct FilterView: View {
    
    @StateObject var vm = FilterViewModel()
    @State private var date = Date()
    
    @Binding var filterArray: [String]
    @Binding var selectedCategory: String
    @Binding var selectedExperience: String
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            loadView()
        }.alert(isPresented: $vm.showError, content: {
            Alert(title: Text(vm.errorMessage))
        })
        .onAppear {
            filterArray.removeAll()
        }

    }
}

extension FilterView  {
    
    func loadView() -> some View {
        
        VStack {
            
            NavBar(action: {
                
                fillArrayWithSelectedCategory()
                self.presentationMode.wrappedValue.dismiss()
            }, titile: "Search")
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text("Search type")
                
                HStack(spacing: 20) {
                    Menu {
                        ForEach(vm.categories, id: \.self){ category in
                            Button(category) {
                                selectedCategory = category
                            }
                        }
                    } label: {
                        HStack  {
                            Text(selectedCategory.isEmpty ? "Category" : selectedCategory)
                                .foregroundColor(.black)
                            Image(ImageName.dropDownIcon.rawValue)
                                .resizable()
                                .frame(width: 20, height: 12)
                            
                        }.padding()
                            .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray)
                        )
                    }
                    
                    Menu {
                        ForEach(vm.experience, id: \.self){ experience in
                            Button(experience) {
                                selectedExperience = experience
                            }
                        }
                    } label: {
                        HStack  {
                            Text(selectedExperience.isEmpty ? "Experience" : selectedExperience)
                                .foregroundColor(.black)
                            Image(ImageName.dropDownIcon.rawValue)
                                .resizable()
                                .frame(width: 20, height: 12)
                            
                        }.padding()
                            .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray)
                        )
                    }
                    Spacer()
                }
                
                Spacer()
                
            }.padding()
            
        }
    }
}

// MARK: - Custom function extension
extension FilterView {
    
    func fillArrayWithSelectedCategory() {
        if !(selectedCategory == "") {
            filterArray.append(selectedCategory)
        }
        if !(selectedExperience == "") {
            filterArray.append(selectedExperience)
        }
    }
    
}


struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(filterArray: .constant([""]), selectedCategory: .constant(""), selectedExperience: .constant(""))
    }
}
