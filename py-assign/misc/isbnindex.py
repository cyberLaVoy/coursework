

def startinput():
	print()
	print("------------------------------")
	print("""What would you like to do?
	[r] Record a Book
	[f] Find a Book
	[l] List all Books
	[q] Quit""")
	torun = input("Enter an option: ")
	while torun != 'r' and torun != 'f' and torun != 'l' and torun != 'q':
		print("Invalid input. Try again...")
		torun = input("Enter an option: ")
	return torun

def title():
	book = input("Enter book title: ")
	return book

def index():
	isbn = input("Enter isbn number: ")
	return isbn


def booklist(bookdict):
	i = 1
	for key in bookdict:
		print("Book #" + str(i) + ": " + bookdict[key])
		i += 1

def main():
	bookdict = {}
	while True:
		torun = startinput()
		print()
		if torun == 'r':
			book = title()
			isbn = index()
			bookdict[isbn] = book
		if torun == 'f':
			isbn = index()
			print()
			if isbn in bookdict:
				print("book title: " + bookdict[isbn])
			else:
				print("I have no recollection of this book")
		if torun == 'l':
			booklist(bookdict)
		if torun == 'q':
			print("okay, bye")
			break
main()
