//
//  DetailGuide.swift
//  EcoGuide
//
//  Created by Torkhani fara on 5/11/2023.
//

import SwiftUI
struct GuideInfo1 {
    var name: String
    var location: String
    var imageName: String
    var galleryImages: [String]
    var description: String
    var reviews: String
    var price: String
}

struct detailGuide: View {
    
    var guideInfo: GuideInfo1
    var body: some View {
        
        ScrollView {
            VStack(alignment:.leading,spacing: 20) {
                // Image en haut de la page
                Spacer()
                Image("guide1")
                    .resizable().cornerRadius(32)
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200).padding(.top,20)
              
                HStack {
                    Text(guideInfo.name)
                        .font(.title)
                        .padding(.top, 16)
                    
                    Spacer()
                    
                    Button("Show Map") {
                        // Action to show the map
                    }
                    .foregroundColor(Color.blue)
                    .padding(.top, 16)
                }
                HStack(alignment: .center) {
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .foregroundColor(.gray)
                        .padding(.bottom,1)
                    Text(guideInfo.reviews).font(.system(size: 16)).foregroundColor(.gray)
                   }
                
                
                    // Location du guide
                    Text(guideInfo.location)
                        .foregroundColor(.gray)
                        .padding(.bottom, 16)
                
                
                Text(guideInfo.description)
                    .font(.title2)
                  
                
                Button("Read more") {
                    // Action to show the map
                }
                .foregroundColor(Color.blue)
                .padding(.top, 16)

                    // Galerie d'images avec bouton "View All"
                    Text("Options")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 16)

                HStack{
                    ZStack {
                        Color(hex: "F3F8FE") // Set your desired background color here
                            .frame(width: 70, height: 70)
                            .cornerRadius(15)
                      
                        Image(systemName: "star.fill") // Replace "star.fill" with the desired SF Symbol name for the icon
                               .resizable()
                               .frame(width: 30, height: 30) // Adjust the size as needed
                               .foregroundColor(Color.gray)
                    
                    }
                    ZStack {
                        Color(hex: "F3F8FE") // Set your desired background color here
                            .frame(width: 70, height: 70)
                            .cornerRadius(15)
                        Image(systemName: "book") // Replace "star.fill" with the desired SF Symbol name for the icon
                               .resizable()
                               .frame(width: 30, height: 30) // Adjust the size as needed
                               .foregroundColor(Color.gray)
                       
                    }
                    ZStack {
                        Color(hex: "F3F8FE") // Set your desired background color here
                            .frame(width: 70, height: 70)
                            .cornerRadius(15)
                        Image(systemName: "heart") // Replace "star.fill" with the desired SF Symbol name for the icon
                               .resizable()
                               .frame(width: 30, height: 30) // Adjust the size as needed
                               .foregroundColor(Color.gray)
                   
                    }
                    ZStack {
                        Color(hex: "F3F8FE") // Set your desired background color here
                            .frame(width: 70, height: 70)
                            .cornerRadius(15)
                        Image(systemName: "star.fill") // Replace "star.fill" with the desired SF Symbol name for the icon
                               .resizable()
                               .frame(width: 30, height: 30) // Adjust the size as needed
                               .foregroundColor(Color.gray)
                    }
                    
                }
                    
               
                    
                    HStack {
                        
                        VStack(alignment: .leading)
                        {
                            Text("Price")
                            Text(guideInfo.price)
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(Color.blue)

                        }
                        Spacer()
                        Button("Book Now") {
                            // Action à effectuer lors du clic sur "Book Now"
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    }
                }
                .padding(.horizontal, 16)

          
            }
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal, 16)
            .padding(.top, -32)
        }
    }


struct DetailGuide_Previews: PreviewProvider {
    static var previews: some View {
        detailGuide(guideInfo: GuideInfo1(
            name: "Flena Foueniya",
            location: "Paris, France",
            imageName: "guide_image",
            galleryImages: ["guide1", "guide2", "guide3"],
            description: "Guide description",
            reviews: "33326",
            price: "326$"
        ))
    }
}
