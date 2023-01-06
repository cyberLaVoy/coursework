from http.server import BaseHTTPRequestHandler, HTTPServer
from tickets_db import Tickets_DB
from urllib.parse import parse_qs
from http import cookies
import json, random


class RequestHandler(BaseHTTPRequestHandler):

    def end_headers(self):
        self.send_header("Access-Control-Allow-Origin", self.headers["Origin"])
        self.send_header("Access-Control-Allow-Credentials", "true")
        self.sendCookie()
        BaseHTTPRequestHandler.end_headers(self)

    def do_GET(self):
        self.loadCookie()
        if self.path == "/tickets":
            self.handleListTickets()
        else:
            self.handle404()

    def do_POST(self):
        self.loadCookie()
        if self.path == "/tickets":
            if not self.checkTicket():
                self.handleCreateTicket()
            else:
                self.handle403()
        else:
            self.handle404()


# Tickets Methods

    def handleListTickets(self):
        db = Tickets_DB()
        tickets = db.getTickets()
        self.sendJSON(tickets)

    def handleCreateTicket(self):
        parsed_body = self.getParsedBody()

        entrant_name = parsed_body["entrant_name"][0]
        entrant_age = parsed_body["entrant_age"][0]
        guest_name = parsed_body["guest_name"][0]
        random_token = random.randrange(0, 7)
        
        db = Tickets_DB()
        db.createTicket(entrant_name, entrant_age, guest_name, random_token)
        
        self.mCookie["oompa"] = "loompa"

        self.send_response(201)
        self.send_header("Content-Type", "text/plain")
        self.end_headers()
        self.wfile.write(bytes("Ticket entry successfully received.", "utf-8"))


# Cookie Methods

    def loadCookie(self):
        if "Cookie" in self.headers:
            self.mCookie = cookies.SimpleCookie(self.headers["Cookie"]) 
        else:
            self.mCookie = cookies.SimpleCookie()

    def sendCookie(self):
        for morsel in self.mCookie.values():
            self.send_header("Set-Cookie", morsel.OutputString()) 

    def checkTicket(self):
        duplicate = False
        if "oompa" in self.mCookie:
            duplicate = True
        return duplicate


# General Methods

    def getParsedBody(self):
        length = int(self.headers["Content-length"])
        body = self.rfile.read(length).decode("utf-8")
        parsed_body = parse_qs(body)
        return parsed_body

    def sendJSON(self, load):
        json_string = json.dumps(load)

        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(bytes(json_string, "utf-8"))

    def handle404(self):
        self.send_response(404)
        self.send_header("Content-Type", "text/plain")
        self.end_headers()
        self.wfile.write(bytes("It seems that this resource has been lost in the chocolate pipes. An Oompa Loompa will be dispatched promptly to recover the artifact.", "utf-8"))

    def handle403(self):
        self.send_response(403)
        self.send_header("Content-Type", "text/plain")
        self.end_headers()
        self.wfile.write(bytes("The Oompa Loompas have already received your ticket. Please try again tomorrow.", "utf-8"))



def main():
    listen = ("0.0.0.0", 8080)
    server = HTTPServer(listen, RequestHandler)

    server.serve_forever()
main()
