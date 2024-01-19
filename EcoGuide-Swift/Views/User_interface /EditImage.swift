////
////  EditImage.swift
////  EcoGuide-Swift
////
////  Created by ben romdhane fedi on 2023-11-21.
////
//
//import SwiftUI
//
//struct EditImage: View {
//    @State private var showingImagePicker = false
//       @State private var inputImage: UIImage?
//       @State private var name: String = "Nom de l'Utilisateur"
//    var body: some View {
//           NavigationView {
//               Form {
//                   Section(header: Text("Informations de l'Utilisateur")) {
//                       HStack {
//                           Image("background") // Remplacer par l'image actuelle de l'utilisateur
//                               .resizable()
//                               .scaledToFill()
//                               .frame(width: 60, height: 60)
//                               .clipShape(Circle())
//                               .overlay(Circle().stroke(Color.gray, lineWidth: 1))
//
//                           VStack(alignment: .leading) {
//                               Text(name) // Nom de l'utilisateur
//                                   .font(.headline)
//                           }
//
//                           Spacer()
//
//                           Button(action: {
//                               showingImagePicker = true
//                           }) {
//                               Text("Modifier la Photo")
//                           }
//                           .sheet(isPresented: $showingImagePicker, onDismiss: uploadImage) {
//                               ImagePicker(image: $inputImage)
//                           }
//                       }
//                   }
//               }
//               .navigationBarTitle("Profil")
//           }
//       }
//
//       func uploadImage() {
//           guard let inputImage = inputImage,
//                 let imageData = inputImage.jpegData(compressionQuality: 0.5) else { return }
//
//           // Préparer la requête HTTP
//           let url = URL(string: "https://votre-domaine.com/api/endpoint")!
//           var request = URLRequest(url: url)
//           request.httpMethod = "POST"
//
//           // Définir le contenu de la requête
//           let boundary = "Boundary-\(UUID().uuidString)"
//           request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//           var body = Data()
//
//           body.append("--\(boundary)\r\n")
//           body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n")
//           body.append("Content-Type: image/jpeg\r\n\r\n")
//           body.append(imageData)
//           body.append("\r\n")
//           body.append("--\(boundary)--\r\n")
//
//           request.httpBody = body
//
//           // Envoyer la requête
//           URLSession.shared.dataTask(with: request) { data, response, error in
//               if let error = error {
//                   print("Erreur: \(error)")
//                   return
//               }
//               // Gérer la réponse ici, par exemple, mise à jour de l'interface utilisateur
//           }.resume()
//       }
//   }
//
//   struct ImagePicker: UIViewControllerRepresentable {
//       @Environment(\.presentationMode) var presentationMode
//       @Binding var image: UIImage?
//
//       func makeUIViewController(context: Context) -> UIImagePickerController {
//           let picker = UIImagePickerController()
//           picker.delegate = context.coordinator
//           return picker
//       }
//
//       func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//
//       func makeCoordinator() -> Coordinator {
//           Coordinator(self)
//       }
//
//       class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//           let parent: ImagePicker
//
//           init(_ parent: ImagePicker) {
//               self.parent = parent
//           }
//
//           func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//               if let uiImage = info[.originalImage] as? UIImage {
//                   parent.image = uiImage
//               }
//
//               parent.presentationMode.wrappedValue.dismiss()
//           }
//       }
//   }
//
//
//
//struct EditImage_Previews: PreviewProvider {
//    static var previews: some View {
//        EditImage()
//    }
//}
