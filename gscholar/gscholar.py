import urllib.request
from html.parser import HTMLParser
import json

class MyHTMLParser(HTMLParser):
    def __init__(self):
        HTMLParser.__init__(self)
        self.in_td = False
        self.seen_citation = False
        self.seen_h_index = False
        self.seen_i10_index = False
        self.citations = -1
        self.h_index = -1
        self.i10_index = -1
    
    def handle_starttag(self, tag, attrs):
        if tag == "td":
            self.in_td = True

    def handle_endtag(self, tag):
        if tag == "td":
            self.in_td = False

    def handle_data(self, data):
        if self.in_td:
            if self.seen_citation:
                self.citations = data
                self.seen_citation = False

            elif self.seen_h_index:
                self.h_index = data
                self.seen_h_index = False

            elif self.seen_i10_index:
                self.i10_index = data
                self.seen_i10_index = False

            elif data == "Citations":
                self.seen_citation = True

            elif data == "h-index":
                self.seen_h_index = True

            elif data == "i10-index":
                self.seen_i10_index = True

    def print_stat(self):
        print(f"Citations: {self.citations}")
        print(f"h-index: {self.h_index}")
        print(f"i10-index: {self.i10_index}")

def get_url(user):
    return f"https://scholar.google.com/citations?hl=en&user={user}"


parser = MyHTMLParser()

with open("users.json", "r") as f:
    users = json.load(f)

for name, user_id in users.items():
    url = get_url(user_id)
    content = urllib.request.urlopen(url).read()
    parser.feed(content.decode("iso-8859-1"))
    print(name)
    print("---")
    parser.print_stat()
    print("")
