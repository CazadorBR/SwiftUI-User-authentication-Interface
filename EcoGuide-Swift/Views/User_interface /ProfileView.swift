//
//  ProfileView.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-15.
//

import SwiftUI
import LocalAuthentication

let editprofile = Editprofile()
struct ProfileView: View {
    let baseURL = "http://192.168.31.247:3000/"

    @State private var name: String = " "
    @State private var surname: String = "******"
    @State private var phoneNumber: String = "( "
    @State private var email: String = " "
    @State private var isEditing: Bool = false
    @State private var showMenu: Bool = false
    @State private var showingAlert = false

    // action for navigation
    @State private var navigateToLogin = false
    @State private var isLouggedout = false
    //print finger
    @State private var isAuthenticated = false
    @State private var isAuthenticating = false
    @State private var isEditProfileViewPresented = false
    
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var displayedImage: Image = Image("background") // Image par défaut

 
    //-------------------------------Tools------------------------------------
    func setUserDetails(_ userDetails: UserDetails) {
            self.name = userDetails.name
            self.email = userDetails.email
            self.phoneNumber = userDetails.telephone
        }
    
    func uploadImage() {
        guard let inputImage = inputImage,
              let imageData = inputImage.jpegData(compressionQuality: 0.5) else { return }

        // Préparer la requête HTTP
 
        let url  = URL(string: baseURL + "EditImageProfile")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        // Ajouter le token d'authentification
          if let accessToken = UserDefaults.standard.string(forKey: "tokenAuth") {
              request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
          }
        // Définir le contenu de la requête
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n")
        body.append("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        body.append("\r\n")
        body.append("--\(boundary)--\r\n")

        request.httpBody = body

        // Envoyer la requête
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erreur: \(error)")
                return
            }
            else{
                UserDefaults.standard.set(imageData, forKey: "userProfileImage")

            }
             
        }.resume()
    }

    //__________________________________User Details_________________________
    func loadUserDetails() {
        isLoading = true
        errorMessage = nil

        editprofile.fetchUserDetails { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let userDetails):
                self.name = userDetails.name
                self.phoneNumber = userDetails.telephone
                self.email = userDetails.email

                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    var body: some View {
 
        ZStack{
            
            DynamicBackgroundView()
            NavigationView {

                List {
                    
                    Section(header: Text("User Information")) {
                        HStack {
                            displayedImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            
                            VStack(alignment: .leading) {
                                Text( name) // User's name
                                    .font(.headline)
                            }
                            Spacer()
                            Button(action: {
                                showingImagePicker = true
                            }) {
                                Image(systemName: "square.and.pencil.circle")
                                   
                                    
                            }
                            .sheet(isPresented: $showingImagePicker, onDismiss: uploadImage) {
                                ImagePicker(image: $inputImage, displayedImage: $displayedImage)
                            }
                            
                        }
                        .onAppear {
                                    // Charger l'image de UserDefaults par défaut
                                    if let imageData = UserDefaults.standard.data(forKey: "userProfileImage") {
                                        if let uiImage = UIImage(data: imageData) {
                                            displayedImage = Image(uiImage: uiImage)
                                        }
                                    }
                                }
                        
                    }
                    
                    // Wallet and Orders section
                    Section(header: Text("Account Details")) {
                        
                        HStack {
                            Text("Phone number")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                            Text(phoneNumber)
                                .font(.headline)
                        }
                        HStack {
                            Text("Mail")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                            Text(email)
                                .font(.headline)
                        }
                    }
                    .onAppear {
                        loadUserDetails()
                    }
                    
                    // Menu options
                    Section {
                    ProfileOptionRow(iconName: "airplane.departure", optionName: "Favorites destinations") {

                    }
                    ProfileOptionRow(iconName: "creditcard.fill", optionName: "Payment") {
                                               // Action for Payment
                                           }
                    ProfileOptionRow(iconName: "person.2.fill", optionName: "Edit your Profile") {
                    authenticateUser()

                    }
                    ProfileOptionRow(iconName: "tag.fill", optionName: "Promotions") {
                                               // Action for Promotions
                    }
                    ProfileOptionRow(iconName: "gearshape.fill", optionName: "Settings") {
                                               // Action for Settings
                    }
                }
                    .sheet(isPresented: $navigateToLogin) {
                         EditProfileView(isEditing: $isEditing, name: $name, surname: $surname, phoneNumber: $phoneNumber, email: $email)
                    }
 
                     Section {
                         Button("Log out") {
                             showingAlert = true
                             }
                             .foregroundColor(.red)
                             .background(
                                 NavigationLink("", destination: Login(), isActive: $isLouggedout)
                                     .opacity(0)
                                     .disabled(true)
                              )
                         }

                     .alert(isPresented: $showingAlert) {
                         Alert(
                             title: Text("Loggout"),
                             message: Text("Are you sur you want to Log Out!."),
                             primaryButton: .default(Text("Yes")) {
                                 let token = UserDefaults.standard.string(forKey: "tokenAuth") ?? ""
                                 if !token.isEmpty {
                                     editprofile.logoutUser(token: token)
                                     UserDefaults.standard.removeObject(forKey: "tokenAuth")
                                     self.showingAlert = true
                                     isLouggedout = true
                                 }
                             },
                             secondaryButton: .cancel()
                         )
                     }
                   
                 
                }
              
            }
        }
        .navigationBarBackButtonHidden(true)// pas de retour (back)

    }
    // empreint authenticate
    private func authenticateUser() {
        isAuthenticating = true
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access this feature"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                           DispatchQueue.main.async {
                               if success {
                                   isEditProfileViewPresented = true
                                   self.navigateToLogin.toggle()

                               } else {
                                   // L'authentification a échoué
                               }
                           }
                       }
        } else {
            // Gérer le cas où Touch ID/Face ID n'est pas disponible ou configuré
            isAuthenticating = false
        }
    }
    
}

//--------------------------------Tools FOR image ---------------------------------
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    @Binding var displayedImage: Image // Ajouté

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
                DispatchQueue.main.async {
                    self.parent.displayedImage = Image(uiImage: uiImage) // Mettre à jour l'image affichée
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


//--------------------------------------------------------------------------------
struct ProfileOptionRow: View {
    var iconName: String
    var optionName: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.blue)
                    .imageScale(.large)
                Text(optionName)
                    .foregroundColor(.black)
            }
        }
    }
}
struct DynamicBackgroundView: View {
    var body: some View {
         LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}









// ----------- ---------------Edit profile View -------------------------------------------------------
struct EditProfileView: View {
    @Binding var isEditing: Bool
    @Binding var name: String
    @Binding var surname: String
    @Binding var phoneNumber: String
    @Binding var email: String
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $name)
                    TextField("Last Name", text: $surname)
                    TextField("Phone Number", text: $phoneNumber)
                    TextField("Email", text: $email)
                }
                
                Section {
                    Button("Save Changes") {
                        editprofile.Editprofile(email:self.email,password: self.surname,name: self.name) { success, responseMessage in
                            DispatchQueue.main.async {
                                self.showingAlert = true
                            }
                            isEditing = false
                        }
                    }
                }
                .alert(isPresented: $showingAlert) {
                    
                    Alert(
                        title: Text("Succes"),
                        message: Text("You are Successfully reseted your password"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .navigationBarTitle(Text("Edit Profile"), displayMode: .inline)
                .navigationBarItems(trailing: Button("Done") {
                    isEditing = false
                })
            }
        }
    }
   
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
    }
}
