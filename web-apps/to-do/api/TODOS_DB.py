import sqlite3

def dict_factory(cursor, row):
    d={}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

class TODOS_DB:
    def __init__(self):
        self.connection = sqlite3.connect("to-dos.db")
        self.connection.row_factory = dict_factory
        self.cursor = self.connection.cursor()

    def __del__(self):
        self.connection.close()

# TODOS operations

    def createTODO(self, short_description, long_description, priority, 
                         desired_completion_date, due_date, date_entered, completion_status):
        Query = "INSERT INTO to_dos (short_description, long_description, priority, desired_completion_date, due_date, date_entered, completion_status) VALUES (?, ?, ?, ?, ?, ?, ?)"

        self.cursor.execute(Query, 
                           (short_description, long_description, priority,
                            desired_completion_date, due_date, 
                            date_entered, completion_status))
        self.connection.commit()

    def getTODOS(self):
        self.cursor.execute("SELECT rowid, * FROM to_dos")
        rows = self.cursor.fetchall()
        return rows 

    def getTODO(self, ID):
        Query = "SELECT * FROM to_dos WHERE rowid = ?"
        self.cursor.execute(Query, (ID,))
        item = self.cursor.fetchall()
        return item

    def replaceTODO(self, short_description, long_description, 
                         desired_completion_date, due_date, 
                         completion_status, ID):
        Query = "UPDATE to_dos SET short_description = ?, long_description = ?, desired_completion_date = ?, due_date = ?, completion_status = ? WHERE rowid = ?"
        self.cursor.execute(Query,
                           (short_description, long_description,
                            desired_completion_date, due_date, 
                            completion_status, ID))
        self.connection.commit()


    def deleteTODO(self, ID):
        Query = "DELETE FROM to_dos WHERE rowid = ?"
        self.cursor.execute(Query, (ID,))
        self.connection.commit()

    def checkTODOID(self, ID):
        self.cursor.execute("SELECT rowid FROM to_dos")
        IDs = self.cursor.fetchall()

        available = False
        for i in range(len(IDs)):
            if IDs[i]["rowid"] == ID:
                available = True
                break
        return available

# USERS operations

    def createUSER(self, email, encrypted_password, fname, lname):
        Query = "INSERT INTO users (email, encrypted_password, fname, lname) VALUES (?, ?, ?, ?)"

        self.cursor.execute(Query, (email, encrypted_password, fname, lname))
        self.connection.commit()

    def getUserAuthInfo(self, email):
        Query = "SELECT rowid, encrypted_password FROM users WHERE email = ?"
        self.cursor.execute(Query, (email,))
        user = self.cursor.fetchall()
        return user

    def getUser(self, ID):
        Query = "SELECT email, fname, lname FROM users WHERE rowid = ?"
        self.cursor.execute(Query, (ID,))
        user = self.cursor.fetchall()
        return user

    def checkUserEmail(self, email):
        self.cursor.execute("SELECT email FROM users")
        emails = self.cursor.fetchall()

        taken = False
        for i in range(len(emails)):
            if emails[i]["email"] == email:
                taken = True
                break
        return taken

