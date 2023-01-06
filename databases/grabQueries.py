
for i in range(5,14):
    if i < 10:
        file_name = "lab0" + str(i) + ".txt"
        title = "lab0" + str(i)
    elif i == 13:
        file_name = "sql_security.txt"
        title = "sql_security"
    else:
        file_name = "lab" + str(i) + ".txt"
        title = "lab" + str(i)
    fin = open(file_name, 'r')
    
    print("*******" + title.upper() + "*******")
    print()
    query_lines = []
    grab_lines = 0
    for line in fin:
        line = line.strip()
        if line == "--------------":
            grab_lines += 1
        if grab_lines%2 == 1:
            query_lines.append(line)
            print(line)
    print()
    print()
    print()
    fin.close()

           

