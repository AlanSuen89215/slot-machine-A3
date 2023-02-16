//
//  CourseRepository.swift
//  slot-machine
//
//  Created by bee on 15/2/2023.
//

import Foundation
import FirebaseFirestore

protocol CourseRepositoryDelegate: AnyObject {
    func onReceivedCourse(courses: [Course])
}

class CourseRepository {
    private let delegate: CourseRepositoryDelegate
    
    public init(delegate: CourseRepositoryDelegate) {
        self.delegate = delegate
    }
    
    public func query() {
        Firestore
            .firestore()
            .collection("Courses")
            .document("1234")
            .addSnapshotListener { [unowned self] (snapshot, error) in
                guard let snapshot = snapshot else {
                    print("Fail to get from firestore!!!!!")
                    return
                }
                
                let dict = snapshot.data()!
                var model = Course(courseDescription: "", courseDuration: "", courseName: "")
                model.courseDescription = dict["courseDescription"] as? String ?? ""
                model.courseDuration = dict["courseDuration"] as? String ?? ""
                model.courseName = dict["courseName"] as? String ?? ""
                var models = [Course]()
                models.append(model)
                /*
                let models = snapshot.documents.compactMap { (document) -> Course? in
                    var model = Course(courseDescription: "", courseDuration: "", courseName: "")
                    let dict = document.data()
                    model.courseDescription = dict["courseDescription"] as? String ?? ""
                    model.courseDuration = dict["courseDuration"] as? String ?? ""
                    model.courseName = dict["courseName"] as? String ?? ""
                    return model
                }*/
                delegate.onReceivedCourse(courses: models)
            }
    }
    
    public func update(course: Course) {
        var dict = [String : Any]()
        dict["courseDescription"] = course.courseDescription
        dict["courseDuration"] = course.courseDuration
        dict["courseName"] = course.courseName
        
        Firestore
            .firestore()
            .collection("Courses")
            .document("1234")
            .setData(dict)
    }
}
