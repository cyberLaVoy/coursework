
def welcomepage():
    print("""Welcome!
Having trouble understanding your leet friend?
No worries...
With this program, you can instantly translate your leet friends message.
Go ahead, give it a shot.""")

def grableet():
    leetfile = input("File name to be translated: ")
    return leetfile

def grabtrans():
    transfile = input("File name to be created with translation: ")
    return transfile

def leetlistcre(leetfile):
    fin = open(leetfile, "r")
    leetlist = []
    for line in fin:
        line = line.strip()
        leetlist.append(line)
    fin.close()
    return leetlist

    
def decode(leetlist):
    leet_letters = " 48CD3FGHIJK1MN0PQR57UVWXYZ@bcd3fghijk1mn0pqr57uvwxyz-:'.,!?"
    eng_letters  = " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-:'.,!?"
    translist = []

    for itop in range(len(leetlist)):
        dumpstr = ""
        placeholder = leetlist[itop]
        for imid in range(len(placeholder)):
            isub = 0
            while placeholder[imid] != leet_letters[isub]:
                isub += 1
            dumpstr += eng_letters[isub]
        translist.append(dumpstr)
    return translist
        
    
def writetrans(translist, transfile):
    fout = open(transfile, "w")
    for i in range(len(translist)):
        fout.write(translist[i] + "\n" )
    fout.close()

def closestatement():
    print("Congrats! Your file has been translated.")
        
def main():
    welcomepage()
    leetfile = grableet()
    transfile = grabtrans()
    leetlist = leetlistcre(leetfile)
    translist = decode(leetlist)
    writetrans(translist, transfile)
    closestatement()
main()
