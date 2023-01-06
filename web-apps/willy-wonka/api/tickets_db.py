import sqlite3

def dict_factory(cursor, row):
    d={}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

class Tickets_DB:
    def __init__(self):
        self.connection = sqlite3.connect("tickets.db")
        self.connection.row_factory = dict_factory
        self.cursor = self.connection.cursor()

    def __del__(self):
        self.connection.close()


# Tickets Operations

    def getTickets(self):
        self.cursor.execute("SELECT * FROM tickets")
        rows = self.cursor.fetchall()
        return rows 

    def createTicket(self, entrant_name, entrant_age, guest_name, random_token):
        Query = "INSERT INTO tickets (entrant_name, entrant_age, guest_name, random_token) VALUES (?, ?, ?, ?)"
        self.cursor.execute( Query, (entrant_name, entrant_age, guest_name, random_token) )
        self.connection.commit()
