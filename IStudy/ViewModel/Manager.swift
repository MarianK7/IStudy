//
//  Manager.swift
//  IStudy
//
//  Created by Marián Keszi on 26/05/2023.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseFirestore

class Manager:ObservableObject{
    @Published var questionList:[QuestionModel] = []
    @Published var todoList:[ToDoDataModel] = []
    @Published var done = false
    init(){
        fetchData()
        FetchTaskData()
    }
    
    func updateCard(question:QuestionModel,newName:String,newQuestion:String,newAnswer:String){
        
        guard let index = self.questionList.firstIndex(where: {$0.id == question.id})else {return}
        self.questionList[index].name = newName
        self.questionList[index].question = newQuestion
        self.questionList[index].answer = newAnswer
        let db = Firestore.firestore()
        let docRef = db.collection("questions").document(question.id)
        docRef.updateData([
            "name": newName,
            "question": newQuestion,
            "answer": newAnswer
            
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document updated successfully.")
            }
        }
    }
    
    func toggleFliping(forQuestion question :QuestionModel){
        guard let index = self.questionList.firstIndex(where: {$0.id == question.id})else{return}
        self.questionList[index].fliping.toggle()
        toggleFilpingValue(forDocumentWithID: question.id, newValue: self.questionList[index].fliping)
    }
    
    func toggleFilpingValue(forDocumentWithID documenID: String,newValue:Bool){
        let db = Firestore.firestore()
        let docRef = db.collection("questions").document(documenID)
        docRef.updateData(["fliping":newValue]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document updated successfully.")
            }
        }
        
    }
    
    func deletcard(at indexSet:IndexSet){
        
        let db = Firestore.firestore()
        let documentIdQuestioList = indexSet.map{
            self.questionList[$0].id
        }
        for documentID in documentIdQuestioList{
            db.collection("questions").document(documentID).delete(){ error in
                if let error = error{
                    print("deletcard\(error)")
                }else{
                    print("Document successfully deleted.")
                }
                
            }
        }
        self.questionList.remove(atOffsets: indexSet)
    }
    
    func saveToFirestore(name: String, question: String, answer: String, fliping: Bool) {
        guard let userId = Auth.auth().currentUser?.uid else {
            // User is not authenticated, handle appropriately
            print("User not authenticated!")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("questions").addDocument(data: [
            "userId": userId, // Store the user ID along with the card data
            "name": name,
            "question": question,
            "answer": answer,
            "fliping": fliping
        ]) { err in
            if let err = err {
                print("\(err)")
            } else {
                // Handle success
            }
        }
        self.fetchData()
    }
    
    func fetchData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            // User is not authenticated, handle appropriately
            print("User not authenticated!")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("questions")
            .whereField("userId", isEqualTo: userId) // Fetch cards belonging to the current user
            .getDocuments { snapshot, error in
                guard error == nil else {
                    print("\(String(describing: error?.localizedDescription))")
                    return
                }
                if let snapshot = snapshot {
                    self.questionList = snapshot.documents.map { data in
                        return QuestionModel(
                            id: data.documentID,
                            userId: data["userId"] as? String ?? "", // Assign the userId from Firestore
                            name: data["name"] as? String ?? "",
                            fliping: data["fliping"] as? Bool ?? false,
                            question: data["question"] as? String ?? "",
                            answer: data["answer"] as? String ?? ""
                        )
                    }
                }
            }
    }
}

extension Manager{
    
    func UpdateTask(task:ToDoDataModel,newTitle:String){
        
        guard let index = self.todoList.firstIndex(where: {$0.id == task.id})else {return}
        self.todoList[index].title = newTitle
        let db = Firestore.firestore()
        
        let docRef = db.collection("Task").document(task.id)
        docRef.updateData([
            "title": newTitle
            
        ]){ err in
            if let err = err {
                print("Error updating task: \(err)")
            } else {
                print("Task updated successfully.")
            }
        }
    }
    
    func toggleDone(_ task: ToDoDataModel) {
        let updatedDoneStatus = !task.done
        
        let db = Firestore.firestore()
        db.collection("Task").document(task.id).setData(["done": updatedDoneStatus], merge: true) { error in
            if error == nil {
                withAnimation {
                    self.FetchTaskData()
                }
            }
        }
    }
    
    func DeleteTask(toDelete:ToDoDataModel){
        
        let db = Firestore.firestore()
        db.collection("Task").document(toDelete.id).delete { error in
            if error == nil{
                self.todoList.removeAll{ item in
                    return item.id == toDelete.id
                    
                }
            }
        }
    }
    
    func SaveTask(title: String, done: Bool) {
        guard let userId = Auth.auth().currentUser?.uid else {
            // User is not authenticated, handle appropriately
            print("User not authenticated!")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("Task").addDocument(data: [
            "userId": userId,
            "title": title,
            "done": done
        ]) { error in
            guard error == nil else {
                print("error")
                return
            }
            
            self.FetchTaskData()
        }
    }
    
    func FetchTaskData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            // User is not authenticated, handle appropriately
            print("User not authenticated!")
            return
        }
        
        let db = Firestore.firestore()
        let tasksRef = db.collection("Task").whereField("userId", isEqualTo: userId)
        
        tasksRef.getDocuments { snapshot, error in
            guard error == nil else {
                print("\(String(describing: error?.localizedDescription))")
                return
            }
            
            if let snapshot = snapshot {
                self.todoList = snapshot.documents.map { data in
                    return ToDoDataModel(
                        id: data.documentID,
                        userId: data["userId"] as? String ?? "",
                        done: data["done"] as? Bool ?? false,
                        title: data["title"] as? String ?? ""
                    )
                }
            }
        }
    }
}
