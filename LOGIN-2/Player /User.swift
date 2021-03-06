//
//  User.swift
//  LOGIN
//
//  Created by Nicola D'Abrosca on 12/02/22.
//

import Foundation
//NICOLA E TROPP SFACCIMM BELL


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
        var reward: Int
        var power: String
        var quantity: String
    }
    
    
    public init() {}
    
    
    private func setLevel(win: Int, lose: Int){
        var crit = UserDefaults.standard.integer(forKey: "crit")
        var newCrit = UserDefaults.standard.integer(forKey: "newCrit")
        
        if((win + lose)%crit == 0){
            user[0].level += 1
            if(newCrit == 0){
                newCrit += 1
            }
            crit += newCrit
            newCrit = crit/4
            
            UserDefaults.standard.set(crit, forKey: "crit")
            UserDefaults.standard.set(newCrit, forKey: "newCrit")

        }
        
        
    }
    
    public func setReward(rew: Int){
        user[0].reward = rew + 1
        print("REWARD AGGIORNATO: \(user[0].reward)")
    }
    
    public func setUserInfo(points:Int,record:Int,win:Int,lose:Int){
        self.user[0].points = points
        self.user[0].record = record
        self.user[0].win = win
        self.user[0].lose = lose
        setLevel(win: win, lose: lose)
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
    
    public func addPowers(brk: Int, ifelse: Int, loop: Int, rtn: Int){
        quantity[0] = quantity[0] + brk
        quantity[1] = quantity[1] + ifelse
        quantity[2] = quantity[2] + loop
        quantity[3] = quantity[3] + rtn
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
                    if(self.user[0].level == 1){
                        UserDefaults.standard.set(3, forKey: "crit")
                        UserDefaults.standard.set(0, forKey: "newCrit")
                    }
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
    
    
    public func updateReward(){
        let request = NSMutableURLRequest(url: NSURL(string:
                                                        "https://quizcode.altervista.org/API/user/updateReward.php")! as URL)
        request.httpMethod = "POST"

        let postUsername = "username=" + user[0].username
        let postReward = "reward=\(user[0].reward)"
        
        let postString = postUsername + "&" + postReward
        
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
    
    public func updatePowers(){
        let request = NSMutableURLRequest(url: NSURL(string:
                                                        "https://quizcode.altervista.org/API/user/addPowers.php")! as URL)
        request.httpMethod = "POST"
        let postUsername = "username=" + user[0].username
        let postBreak = "break= \(quantity[0])"
        let postIfelse = "if_else= \(quantity[1])"
        let postLoop = "loop= \(quantity[2])"
        let postReturn = "return= \(quantity[3])"
        let postString = postUsername + "&" + postBreak + "&" + postIfelse + "&" + postLoop + "&" + postReturn
        
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
