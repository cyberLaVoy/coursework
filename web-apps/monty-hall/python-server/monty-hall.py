from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import parse_qs
import json

class MyHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/sessions":
            sessions = []

            fin = open("sessions.txt", 'r')
            for line in fin:
                sessions.append(eval(line))
            fin.close()

            json_string = json.dumps(sessions)

            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Access-Control-Allow-Origin", "*")
            self.end_headers()
            self.wfile.write(bytes(json_string, "utf-8"))
        else:
            self.send_response(404)
            self.send_header("Content-Type", "text/plain")
            self.end_headers()
            self.wfile.write(bytes("RESOURCE NOT FOUND", "utf-8"))
        return

    def do_POST(self):
        if self.path == "/sessions":
            length = int(self.headers["Content-length"])
            body = self.rfile.read(length).decode("utf-8")
            parsed_body = parse_qs(body)

            fout = open("sessions.txt", 'a')
            fout.write(str(parsed_body) + '\n')
            fout.close()

            self.send_response(201)
            self.send_header("Access-Control-Allow-Origin", "*")
            self.end_headers()
            self.wfile.write(bytes("Post complete.", "utf-8"))
        else:
            self.send_response(404)
            self.send_header("Content-Type", "text/plain")
            self.end_headers()
            self.wfile.write(bytes("RESOURCE NOT FOUND", "utf-8"))
        return


def main():
            #(IPaddress, port)
    listen = ("0.0.0.0", 8080)
    server = HTTPServer(listen, MyHandler)

    print("Listening...")
    server.serve_forever()
main()

