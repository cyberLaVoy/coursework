import sqlite3

def dict_factory(cursor, row):
    d={}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

class WizardsDB:
    def __init__(self):
        self.connection = sqlite3.connect("wizard_db.db")
        self.connection.row_factory = dict_factory
        self.cursor = self.conection.cursor()

    def __del__(self):
        self.connection.close()

    def createWizard(self, name, age, color, height):
        self.cursor.execute("INSERT INTO wizards (name, age, color, height) VALUES (?, ?, ?, ?)", 
                               (name, age, color, height))
        self.connection.commit()


    def getWizards(self):
        self.cursor.execute("SELECT * FROM wizards")
        rows = cursor.fetchall()
        return rows 
