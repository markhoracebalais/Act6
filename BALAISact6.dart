import 'dart:io';

class Book {
  String Title = " ";
  String Author = " ";
  String Genre = " ";
  int ID_Borrower = 0;
  bool available = true;
  List genre = [  // the Genres that library have
    "Computer Science",
    "Philosophy",
    "Pure Science",
    "Art and Recreation",
    "History"
    
  ];
  addBook() {
    stdout.write("Title : ");
    Title = stdin.readLineSync()!;
    stdout.write("Author :");
    Author = stdin.readLineSync()!;
    //the Genre is looped until there is a valid input
    do {
      stdout.write("Genre: ");
      Genre = stdin.readLineSync()!;
    } while (!genre.contains(Genre));
  }

  display() {
    stdout.write(Title + " - " + Author + " - " + Genre);
    if (available == true) {
      print(" Status : Available");
    } else {
      print(" Status : Borrowed");
    }
  }
}
//library needs to know their full name, address, and what books they're borrowing.
class Customer {
  String Name = " ";
  String Address = " ";
  List BorrowedBooks = [];

  addCustomer() {
    stdout.write("Name : ");
    Name = stdin.readLineSync()!;
    stdout.write("Address :");
    Address = stdin.readLineSync()!;
  }

  display() {
    
    stdout.write("Name: " + Name + " Address: " + Address + " Books : ");
    BorrowedBooks.forEach((e) {
      stdout.write(BookDetails[e].Title + ", ");
    });
    print(" ");
  }
}

displayOptions() {
  print("********* E-LIBRARY **********");
  print("PRESS: ");
  print("1: Add Book ");
  print("Genres Available: ");
  print('"Computer Science",\t"Philosophy"');
  print('"Pure Science",\t"History"');
  print('"Art and Recreation"');
}
//Map for ISBN : Book Object
var BookDetails = new Map(); 
//List for ISBN, must be unique to each book
List ISBN = []; 
//Total Number of Books
int bookCount = 0; 

var CustomerDetails = new Map(); //Map for customer USERNAME : customer Object
List USERNAME =
    []; // List for customer USERNAME, which is unique in every customer
int customerCount = 0; //Total Number of Customer

main() {
  displayOptions();
  var choice = " ";

  // Iteration process without exiting the program
  do {
    stdout.write("Enter Choice: ");
    choice = stdin.readLineSync()!;
    switch (choice) {
      case '1': //Add Book Option
        {
          var temp = " ";
          stdout.write("Enter ISBN : ");
          temp = stdin.readLineSync()!;
          if (ISBN.contains(temp)) {
            print("That ISBN already Exist");
          } else {
            ISBN.add(temp);
            Book b = new Book();
            b.addBook();
            BookDetails[temp] = b;
            bookCount++;
            stdout.write(b.Title);
            print(" Added");
          }
        }
        break;

      case '2': // Display All Available
        {
          print("All Books: ");
          for (int a = 0; a < bookCount; a++) {
            stdout.write(ISBN[a] + " - ");
            BookDetails[ISBN[a]].display();
          }
        }
        break;

      case '3': // Display Not Available
        {
          print("Borrowed Books: ");
          for (int a = 0; a < bookCount; a++) {
            if (BookDetails[ISBN[a]].available == false) {
              BookDetails[ISBN[a]].display();
            }
          }
        }
        break;

      case '4': // Display Available
        {
          print("Available Books");
          for (int a = 0; a < bookCount; a++) {
            if (BookDetails[ISBN[a]].available == true) {
              BookDetails[ISBN[a]].display();
            }
          }
        }
        break;

      case '5': // Add New Customer
        {
          var temp = " ";
          stdout.write("Enter Username : ");
          temp = stdin.readLineSync()!;
          if (USERNAME.contains(temp)) {
            print("That Username already Exist");
          } else {
            USERNAME.add(temp);
            Customer c = new Customer();
            c.addCustomer();
            CustomerDetails[temp] = c;
            customerCount++;
            print("$temp Added");
          }
        }
        break;

      case '6': // Display All Customer
        {
          for (int a = 0; a < customerCount; a++) {
            CustomerDetails[USERNAME[a]].display();
          }
        }
        break;

      case '7': //Borrow Book
        {
          var tempUname = " ";
          stdout.write("Enter Username : ");
          tempUname = stdin.readLineSync()!;
          if (!USERNAME.contains(tempUname)) {
            print("Username doesn't Exist, try again");
            continue;
          }
          var tempISBN = " ";
          stdout.write("Enter ISBN : ");
          tempISBN = stdin.readLineSync()!;
          if (!ISBN.contains(tempISBN)) {
            print("Book doesn't Exist, try again");
            continue;
          }

          BookDetails[tempISBN].available = false;
          CustomerDetails[tempUname].BorrowedBooks.add(tempISBN);
        }
        break;

      default:
        break;
    }
  } while (choice != '9');
}