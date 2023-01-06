import student
import bst
import time

def insertStudents(students, file_name):
    start_time = time.time()

    unavailable = 0
    fin = open(file_name, 'r')
    for line in fin:
        info = line.split()
        f_name = info[0]
        l_name = info[1]
        ssn = info[2]
        email = info[3]
        age = info[4]
        S = student.Student(f_name, l_name, ssn, email, age)
        if not students.insert(S):
            unavailable += 1
    fin.close()

    print("Total unavailable for insertion: " + str(unavailable))

    end_time = time.time()
    duration = end_time - start_time
    print("Inserting students took " + str(duration) + " seconds")

total_ages = 0
def incrementTotalAges(student):
    global total_ages
    total_ages += int(student.getAge())

def averageAge(students):
    start_time = time.time()

    students.traverse(incrementTotalAges)
    global total_ages
    average = total_ages/students.trueCount()
    print("Average age for all students: " + str(average))

    end_time = time.time()
    duration = end_time - start_time
    print("Process took " + str(duration) + " seconds")

def specificAverageAge(students, file_name):
    start_time = time.time()

    specific_total_ages = 0
    total_retrieved_students = 0
    unavailable = 0
    fin = open(file_name, 'r')
    for line in fin:
        ssn = line.strip()
        dummyStudent = student.Student("", "", ssn, "", 0)
        retrieved_student = students.retrieve(dummyStudent)
        if retrieved_student is not None:
            specific_total_ages += int(retrieved_student.getAge())
            total_retrieved_students += 1
        else:
            unavailable += 1
    fin.close()

    print("Total unavailable for retrieval: " + str(unavailable))

    average = specific_total_ages/total_retrieved_students
    print("Average age of retrieved students: " + str(average))

    end_time = time.time()
    duration = end_time - start_time
    print("Process took " + str(duration) + " seconds")



def removeSpecific(students, file_name):
    start_time = time.time()

    unavailable = 0
    fin = open(file_name, 'r')
    for line in fin:
        ssn = line.strip()
        dummyStudent = student.Student("", "", ssn, "", 0)
        if not students.delete(dummyStudent):
            unavailable += 1
    fin.close()

    print("Total unavailable for deletion: " + str(unavailable))

    end_time = time.time()
    duration = end_time - start_time
    print("Process took " + str(duration) + " seconds")
   
def main():
    students = bst.BST()
    print("*****Insert Students*****")
    insertStudents(students, "insertNamesMedium.txt")
    print()

    print("*****Calulate Average Age of All Students*****")
    averageAge(students)
    print()

    print("*****Remove Specific Students*****")
    removeSpecific(students, "deleteNamesMedium.txt")
    print()

    print("*****Calulate Average Age of Specific Students*****")
    specificAverageAge(students, "retrieveNamesMedium.txt")

main()
