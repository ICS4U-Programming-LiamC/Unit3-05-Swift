//
//  MyStackInt.swift
//
//  Created by Liam Csiffary
//  Created on 2022-04-29
//  Version 1.0
//  Copyright (c) 2022 IMH. All rights reserved.
//
//  The MyStackInt program defines a stack to be used in main
//  has various useful methods, all are variations of pop, peek, and push

import Foundation

public class Student {
  
  var firstName = ""
  var midInit = "N.M.N"
  var lastName = ""
  var grade = 0
  var IEP = false
  
  init(_ firstName: String, _ midInit: String, _ lastName: String, _ grade: Int, _ IEP: Bool) {
    self.firstName = firstName
    self.midInit = midInit
    self.lastName = lastName
    self.grade = grade
    self.IEP = IEP
  }  

  public func display() {
    print("Name (First Middle. Last):", firstName, midInit, ".", lastName)
    print("Grade:", grade)
    print("IEP:", IEP)
  }

  public func editFirst(_ newFirst: String) {
    firstName = newFirst
  }

  public func editMiddle(_ newMid: String) {
    midInit = newMid
  }

  public func editLast(_ newLast: String) {
    lastName = newLast
  }

  public func editGrade(_ newGrade: Int) {
    grade = newGrade
  }

  public func editIEP(_ newIEP: Bool) {
    IEP = newIEP
  }
}


/////////////////////// ACTUAL CODE /////////////////////

//
//  main.swift
//
//  Created by Liam Csiffary
//  Created on 2022-04-29
//  Version 1.0
//  Copyright (c) 2022 IMH. All rights reserved.
//
//  The main.swift program creates and tests the object from the MyStackInt class


func readFile(_ path: String) -> [String] {
  var arrayOfStrings: [String] = []
  errno = 0
  if freopen(path, "r", stdin) == nil {
    perror(path)
    return []
  }
  while let line = readLine() {
    arrayOfStrings.append(String(line))
    //do something with lines..
  }
  return arrayOfStrings
}

// gets the index of the student
public func getStudent(_ studentList: [Student]) -> Int {
  var numStudents: [Int] = []

  while (true) {
    print("Which student would you like to edit?")
    for (i, _) in studentList.enumerated() {
      if (studentList.count < i) {
        print(studentList[i].firstName, ", or")
      } else {
        print(studentList[i].firstName)
      }
    }

    var userInput = readLine() ?? "Liam"
    userInput = userInput.lowercased()

    for (i, _) in studentList.enumerated() {
      if (userInput == (studentList[i].firstName).lowercased()) {
        numStudents.append(i)
      }
    }

    if (numStudents.count == 1) {
      print("You are editing", studentList[numStudents[0]].firstName)
      return numStudents[0]
      
    } else if (numStudents.count > 1) {
      print("There is more than 1 student by that first name.")
      print("Which student would you like to edit? Please input their last name.")

      for each in numStudents {
        studentList[each].display()
      }

      userInput = readLine()!.lowercased()

      for each in numStudents {
        if (userInput == studentList[each].lastName.lowercased()) {
          print("You are editing", studentList[each].lastName)
          return each
        }
      }
      
    }
  }
}

func lineReader() -> String {
  if let temp = readLine() {
    return temp
  } else {
    return "Probably nil"
  }
}

// main function
func main() {
  //let file = "testCases.txt"
  //let testStrings: [String] = readFile(file)
  
  var studentArray: [Student] = [Student("Liam", "M", "Csiffary", 12, false)]
  studentArray.append(Student("Housein", "N.M.N", "Shaib", 12, true))
  studentArray.append(Student("Andy", "D", "Frigstad", 12, false))

  // var i = 0
  // while (i < testStrings.count) {
  //   while (testStrings[i] == "") {
  //     i += 1
  //   }

  //   if (testStrings[i + 1] == "_") {
  //     let student = Student(testStrings[i], "N.M.N", testStrings[i + 2],
  //           Int(testStrings[i + 3])!, Bool(testStrings[i + 4])!);
  //     studentArray.append(student)
  //   } else {
  //     let student = Student(testStrings[i], testStrings[i + 1], testStrings[i + 2],
  //           Int(testStrings[i + 3])!, Bool(testStrings[i + 4])!);
  //     studentArray.append(student)
  //   }
  //   i += 5
  // }
  // studentArray.remove(at: 0)
  
  for each in studentArray {
    each.display()
  }

  // student editor
  while (true) {
    print("Would you like to edit these students? (y/n) or view students? (view)")
    let userInputYNView = lineReader()
    print(userInputYNView)

    
    if (userInputYNView == "y") {
      let whichStu = getStudent(studentArray)

      while (true) {
        print("\nWhich property would you like to edit?")
        print("First, middle, last,")
        print("grade, or IEP.\n")

        let userInputProp = (readLine()!).lowercased()

        if (userInputProp == "first") {
          print("Please input a new first name, be sure to capitalize.")
          let userInputFirst = readLine() ?? ""
          studentArray[whichStu].editFirst(userInputFirst)
          break
          
        } else if (userInputProp == "middle") {
          print("Please input a new middle name. Input non for no middle name.")
          let userInputMid = readLine() ?? ""

          if (userInputMid == "none" || userInputMid == "None") {
            studentArray[whichStu].editMiddle("N.M.N")
            
          } else {
            studentArray[whichStu].editMiddle(((userInputMid).first)!.uppercased())
            
          }
          break
          
        } else if (userInputProp == "last") {
          print("Please input new last name, be sure to capitalize.")
          let userInputLast = readLine() ?? ""
          studentArray[whichStu].editLast(userInputLast)
          break
          
        } else if (userInputProp == "grade") {
          var userInputInt = -1
          while (true) {
            print("Please input a new grade")
            let userInputGrade = readLine() ?? ""

            userInputInt = Int(userInputGrade) ?? -1

            if (userInputInt < 1) {
              print("Please input a natural number")
              
            } else {
              break
            }
          }
          studentArray[whichStu].editGrade(userInputInt)
          break
          
        } else if (userInputProp == "IEP") {
          var IEPBool = false
          while (true) {
            print("Please input true/false")
            let userInputIEP = readLine() ?? ""

            if (try? Bool(userInputIEP)) != nil {
              IEPBool = Bool(userInputIEP)!
              break
            }
          }
          studentArray[whichStu].editIEP(IEPBool)
          break
          
        } else {
          print("Not valid input")
        }
      }
      
    } else if (userInputYNView == "n") {
      print("You are not editing any students")
      break
      
    } else if (userInputYNView == "view") {
      for each in studentArray {
        each.display()
      }
    } else {
      print("Please enter either 'y' or 'n'")
    }
  }
  print("Exited")
}

main()
