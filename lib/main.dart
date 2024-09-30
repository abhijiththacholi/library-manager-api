import 'dart:io';
import 'details.dart';
import 'library_manager.dart';

void main() async {
  LibraryManager libraryManager = LibraryManager();

  
  while (true) {
    print('''
Library management
1. Add Book
2. View Books
3. Update Book
4. Delete Book
5. Search Books
6. Add Author
7. View All Authors
8. Update Author
9. Delete Author
10. Add Member
11. View All Members
12. Update Member
13. Delete Member
14.search Member
15. Exit
Enter your choice:''');

    var choice = stdin.readLineSync();
    if (choice == '1') {
      // Add Book

      print('Enter title: ');
      String title = stdin.readLineSync()!;
      print('Enter author: ');
      String author = stdin.readLineSync()!;
      print('Enter publication year: ');
      int publicationYear = int.parse(stdin.readLineSync()!);
      print('Enter ISBN: ');
      String isbn = stdin.readLineSync()!;
      await libraryManager.addBook(Book(title, author, publicationYear, isbn));
      

    } else if (choice == '2') {
      // View All Books

      List<Book> books = await libraryManager.viewAllBooks();
     if (books.isNotEmpty) {
    for (var book in books) {
      print('Title: ${book.title}, Author: ${book.author}, Year: ${book.publishedYear}, ISBN: ${book.isbn}');
    }
  } else {
    print('No books found.');
  }
      } else if (choice == '3') {
      // Update Book

      print('Enter ISBN of the book to update: ');
      String isbn = stdin.readLineSync()!;
      print('Enter new title: ');
      String title = stdin.readLineSync()!;
      print('Enter new author: ');
      String author = stdin.readLineSync()!;
      print('Enter publication year: ');
      int publicationYear = int.parse(stdin.readLineSync()!);
      await libraryManager.updateBook(isbn, Book(title, author, publicationYear, isbn));
    } else if (choice == '4') {
      // Delete Book

      print('Enter ISBN to delete book: ');
      String isbn = stdin.readLineSync()!;
     await libraryManager.deleteBook(isbn);
     
    } else if (choice == '5') {
      // Search Books

      print('Enter title to search (leave empty if not searching by title): ');
      String? title = stdin.readLineSync();
      print(
          'Enter author to search (leave empty if not searching by author): ');
      String? author = stdin.readLineSync();
      List<Book> books = libraryManager.searchBooks(
        title: title,
        author: author,
      );
      for (var book in books) {
        print(
            'Title: ${book.title}, Author: ${book.author}, Year: ${book.publishedYear}, ISBN: ${book.isbn}, Lent: ${book.isLent}, Due Date: ${book.dueDate}');
      }
   
    } else if (choice == '6') {
      // Add Author

      print('Enter name: ');
      String name = stdin.readLineSync()!;
      await libraryManager.addAuthor(Author(name, []));

      // await libraryManager.saveAuthour();
    } else if (choice == '7') {
      // View All Authors

      List<Author> authors = await libraryManager.viewAllAuthors();
      for (var author in authors) {
        print('Name: ${author.name}, Books Written:');
        for (var isbn in author.booksWritten) {
          var book = libraryManager.books.firstWhere(
              (book) => book.isbn == isbn,
              orElse: () => Book('Unknown', 'Unknown', 0, 'Unknown'));
          print(
              '  Title: ${book.title}, Year: ${book.publishedYear}, ISBN: ${book.isbn}');
        }
      }
    } else if (choice == '8') {
      // Update Author

      print('Enter name of the author to update: ');
      String name = stdin.readLineSync()!;
      print('Enter new name: ');
      String newName = stdin.readLineSync()!;
     await libraryManager.updateAuthor(name, Author(newName, []));
    } else if (choice == '9') {
      // Delete Author

      print('Enter name of the author to delete: ');
      String name = stdin.readLineSync()!;
     await libraryManager.deleteAuthor(name);
    } else if (choice == '10') {

      // Add Member

      print('Enter name: ');
      String name = stdin.readLineSync()!;
      print('Enter Member ID: ');
      String memberId = stdin.readLineSync()!;
     await libraryManager.addmember(Member(name, memberId, []));
     
    } else if (choice == '11') {
      // View All Members

     List<Member> members = await libraryManager.viewAllMembers();
  if (members.isNotEmpty) {
    for (var member in members) {
      print('Name: ${member.name}, Member ID: ${member.memberId}, Borrowed Books: ${member.borrowedBooks}');
    }
  } else {
    print('No members found.');
  }
} 
     else if (choice == '12') {
      // Update Member

      print('Enter Member ID of the member to update: ');
      String memberId = stdin.readLineSync()!;
      print('Enter new name: ');
      String name = stdin.readLineSync()!;
      await libraryManager.updateMember(memberId, Member(name, memberId, []));
    } else if (choice == '13') {
      // Delete Member

      print('Enter Member ID of the member to delete: ');
      String memberId = stdin.readLineSync()!;
      libraryManager.deleteMember(memberId);
    } else if (choice == '14') {
      print('Enter name to search (leave empty if not searching by name): ');
      String? name = stdin.readLineSync();

      print('Enter Member ID to search (leave empty if not searching by ID): ');
      String? memberId = stdin.readLineSync();

      List<Member> members = libraryManager.searchMembers(
        name: name?.isEmpty ?? true ? null : name,
        memberId: memberId?.isEmpty ?? true ? null : memberId,
      );

      if (members.isNotEmpty) {
        for (var member in members) {
          print(
              'Name: ${member.name}, Member ID: ${member.memberId}, Borrowed Books: ${member.borrowedBooks}');
        }
      } else {
        print('No members found with the given search criteria.');
      }
    } else if (choice == '15') {
      // Exit
      print('Exiting...');
      break;
    } else {
      print('Invalid choice. Please try again.');
    }
  }
}