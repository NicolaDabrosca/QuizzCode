//
//  User.swift
//  LOGIN
//
//  Created by Nicola D'Abrosca on 12/02/22.
//

import Foundation



public class User: Identifiable{
    struct Entry: Decodable{
        var error: Bool
        var message: String
        var utente: UserStruct
        
    }
    
    public struct FriendsList: Decodable{
        var amici: [Friend]
    }
    
    public struct Friend: Decodable, Hashable{

        var username:String
    }
    
    public struct UserStruct: Decodable{
        var username: String
        var points: Int
        var record: Int
        var win: Int
        var lose: Int
        var level: Int
        var power: String
        var quantity: String
    }
    
    
    public init() {}
    
    
    public func setUserInfo(points:Int,record:Int,win:Int,lose:Int){
        self.user[0].points = points
        self.user[0].record = record
        self.user[0].win = win
        self.user[0].lose = lose
        print("AGGIORNAMENTO ****************************")
        print("")
        printUser()
    }
    
    public var quantity:[Int] = []
    
    var user: [UserStruct] = []
    private var friendList = FriendsList(amici: [])
    
    public func getUserStruct()->[UserStruct]{
        return user
    }
    var usernameLocal: String = ""
    public func setUser(username:String){
        usernameLocal = username
    }
    
    public func printUser(){
        print("USERNAME: " + user[0].username)
        print(" POINTS: " + String(describing: user[0].points) )
        print(" RECORD: " + String(describing: user[0].record ))
        print(" WIN: " + String(describing: user[0].win))
        print(" LOSE: " + String(describing: user[0].lose))
        print(" LEVEL: " + String(describing: user[0].level))
        print(" POWER: " + user[0].power)
        print(" QUANTITY: " + String(describing: quantity))
    }
    
    public func getFriendList() -> FriendsList{
        return self.friendList
    }
    
    
    public func loginUser(){
        
//        print("USER: " + user[0].username)
        let request = NSMutableURLRequest(url: NSURL(string:
                                                        "https://quizcode.altervista.org/API/user/register.php")! as URL)
        request.httpMethod = "POST"
        let postString = "username=" + usernameLocal
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let parsedJSON = try jsonDecoder.decode(Entry.self, from: data)
                    self.user.insert(parsedJSON.utente, at: 0)
                    let array = self.user[0].quantity.components(separatedBy: ", ")
                    self.quantity = array.map { Int($0)!} // [1, 2, 10]

                    self.printUser()
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    public func getFriendsListUser() {
        let request = NSMutableURLRequest(url: NSURL(string:
                                                        "https://quizcode.altervista.org/API/user/getFriendsList.php")! as URL)
        request.httpMethod = "POST"
        let postString = "username=" + usernameLocal
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
//        var friends:[Friend] = []
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                
            }
            
           
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let parsedJSON = try jsonDecoder.decode(FriendsList.self, from: data)
                    
                    self.friendList.amici = parsedJSON.amici
                    
                    for friend in parsedJSON.amici {

                        print("FRIEND: " + friend.username)
                    }
                   
                    

                } catch {
                    print(error)
                }
            }
        }
        task.resume()
      
    }
    
    
    
    
    public func updateUserInfo(){
        let request = NSMutableURLRequest(url: NSURL(string:
                                                        "https://quizcode.altervista.org/API/user/update_user_info.php")! as URL)
        request.httpMethod = "POST"
        print("")
        print("USER STATS: ****************")

        printUser()
        let postUsername = "username=" + user[0].username
        let postPoints = "points= \(user[0].points)"
        let postRecord = "record= \(user[0].record)"
        let postWin = "win= \(user[0].win)"
        let postLose = "lose= \(user[0].lose)"
        let postLevel = "level= \(user[0].level)"
        
        let postBreak = "break= \(quantity[0])"
        let postIfelse = "if_else= \(quantity[1])"
        let postLoop = "loop= \(quantity[2])"
        let postReturn = "return= \(quantity[3])"
        let postString = postUsername + "&" + postPoints + "&" + postRecord + "&" + postWin + "&" + postLose + "&" +
                         postLevel + "&" + postBreak + "&" + postIfelse + "&" + postLoop + "&" + postReturn
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let parsedJSON = try jsonDecoder.decode(Entry.self, from: data)
                    self.user.insert(parsedJSON.utente, at: 0)
                    let array = self.user[0].quantity.components(separatedBy: ", ")
                    self.quantity = array.map { Int($0)!} // [1, 2, 10]

                    self.printUser()
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    
    
    
    
}
