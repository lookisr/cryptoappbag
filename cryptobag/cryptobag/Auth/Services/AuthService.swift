
import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseAppCheck

class AuthService {
    public static let shared = AuthService()
    
    private init (){
        
    }
    
    public func registerUser(with userRequest:RegisterUserRequest, completion:@escaping(Bool,Error?)-> Void){
        
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        Auth.auth().createUser(withEmail: email, password: password){
            result, error in
            if let error = error{
                completion(false,error)
                return
            }
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "username":username,
                    "email":email,
                    "cost": Double(0)
                    
                ]){
                    error in
                    if let error = error {
                        completion(false,error)
                        return
                    }
                    completion(true,nil)
                }
        }
    }
    
    public func signIn(with userRequest: LoginUserRequest, completation:@escaping
                       (Error?)-> Void){
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password){
            result , error in
            if let error = error {
                completation(error)
                return
            }else{
                completation(nil)
            }
        }
    }
    
    
    public func signOut(completion: @escaping (Error?)->Void) {
           do {
               try Auth.auth().signOut()
               completion(nil)
           } catch let error {
               completion(error)
           }
       }
    
    public func forgotPassword(with email: String, completion: @escaping (Error?) -> Void) {
           Auth.auth().sendPasswordReset(withEmail: email) { error in
               completion(error)
           }
       }
       
       public func fetchUser(completion: @escaping (User?, Error?) -> Void) {
           guard let userUID = Auth.auth().currentUser?.uid else { return }

           let db = Firestore.firestore()

           db.collection("users")
               .document(userUID)
               .getDocument { snapshot, error in
                   if let error = error {
                       completion(nil, error)
                       return
                   }

                   if let snapshot = snapshot,
                      let snapshotData = snapshot.data(),
                      let username = snapshotData["username"] as? String,
                      let email = snapshotData["email"] as? String,
                      let cost = snapshotData["cost"] as? Double{
                       let user = User(username: username, email: email, userUID: userUID, cost: 0)
                       
                       completion(user, nil)
                   }

               }
       }
}
