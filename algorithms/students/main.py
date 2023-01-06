import student
import time

def insertStudents(students):
    start_time = time.time()

    fin = open("students.txt", 'r')
    for line in fin:
        info = line.split()
        f_name = info[0]
        l_name = info[1]
        ssn = info[2]
        email = info[3]
        age = info[4]
        duplicate = False
        for i in range(len(students)):
            if students[i].getSSN() == ssn:
                duplicate = True
        if not duplicate:
            S = student.Student(f_name, l_name, ssn, email, age)
            students.append(S)
        else:
            print("Duplicate entry: " + ssn)
    fin.close()

    end_time = time.time()
    duration = end_time - start_time
    print("Inserting students took " + str(duration) + " seconds")

def averageAge(students):
    start_time = time.time()

    total = 0
    for i in range(len(students)):
        age = students[i].getAge()
        total += int(age)
    average = total/len(students)
    print("Average age for all students: " + str(average))

    end_time = time.time()
    duration = end_time - start_time
    print("Process took " + str(duration) + " seconds")

def specificAverageAge(students):
    start_time = time.time()

    total_age = 0
    total_students = 0
    fin = open("retrieve.txt", 'r')
    for line in fin:
        line = line.strip()
        available = False
        for i in range(len(students)):
            ssn = students[i].getSSN()
            if ssn == line:
                age = students[i].getAge()
                total_age += int(age)
                available = True
        if available:
            total_students += 1
        if not available:
            print(line + " is not available for retrieval")
    fin.close()
    average = total_age/total_students
    print("Average age of retrieved students: " + str(average))

    end_time = time.time()
    duration = end_time - start_time
    print("Process took " + str(duration) + " seconds")

def removeSpecific(students):
    start_time = time.time()

    fin = open("remove.txt", 'r')
    for line in fin:
        line = line.strip()
        available = False
        for i in range(len(students)):
            ssn = students[i].getSSN()
            if ssn == line:
                available = True
                del students[i]
                break
        if not available:
            print(line + " is not available for deletion")
    fin.close()

    end_time = time.time()
    duration = end_time - start_time
    print("Process took " + str(duration) + " seconds")
   
def main():
    students = []
    print("*****Insert Students*****")
    insertStudents(students)
    print()

    print("*****Calulate Average Age of All Students*****")
    averageAge(students)
    print()

    print("*****Remove Specific Students*****")
    removeSpecific(students)
    print()

    print("*****Calulate Average Age of Specific Students*****")
    specificAverageAge(students)

main()
