import 'details.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;  // Missing import for HTTP

class LibraryManager {
  static const String baseUrl = 'https://crudcrud.com/api/a1d82edd69604f789a5cb366daba0c51';

  // Base URL for API
  List<Book> books = [];
  List<Author> authors = [];
  List<Member> members = [];

  // Add Book
 Future<void> addBook(Book book) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/books'),  // Make sure endpoint is correct
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(book.toJson()),
    );

    if (response.statusCode == 201) {
      books.add(book);
      print('Book added successfully');
    } else {
      print('Failed to add book. Status code: ${response.statusCode}');
      print('Error: ${response.body}');
    }
  } catch (e) {
    print('Error adding book: $e');
  }
}

  // View All Books
 Future<List<Book>> viewAllBooks() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/books'));


    if (response.statusCode == 200) {
      // Decoding the response
      List<dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.isEmpty) {
        print('No books found.');
        return [];
      }

      // Mapping the JSON to Book objects
      books = jsonResponse.map((data) {
        
        return Book.fromJson(data);
      }).toList();
      return books;
    } else {
      print('Failed to load books. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error fetching books: $e');
    return [];
  }
}


    // Update Book by ISBN
   Future<void> updateBook(String isbn, Book updatedBook) async {
    final response = await http.put(
      Uri.parse('$baseUrl/book/$isbn'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedBook.toJson()),
    );

    if (response.statusCode == 200) {
      books = books.map((book) => book.isbn == isbn ? updatedBook : book).toList();
      print('Book updated successfully');
    } else {
      print('Failed to update book: ${response.body}');
    }
  }


  Future<String?> _getBookIdByIsbn(String isbn) async {
    final response = await http.get(Uri.parse('$baseUrl/books'));

    if (response.statusCode == 200) {
      final books = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      final book =
          books.firstWhere((book) => book['isbn'] == isbn, orElse: () => {});
      return book.isNotEmpty ? book['_id'] : null;
    } else {
      print('Failed to fetch books: ${response.body}');
      return null;
    }
  }


  // Delete Book by ISBN
Future<void> deleteBook(String isbn) async {
  try {
    // Find the book by ISBN
        final bookId = await _getBookIdByIsbn(isbn);
  
    if (bookId != null) {
      final response = await http.delete(Uri.parse('$baseUrl/books/$bookId'));

      if (response.statusCode == 200) {
        books.removeWhere((book) => book.isbn == isbn);
         print('Book delete Successfully\n');
      } else {
        print('Failed to delete book: ${response.body}\n');
      }
    } else {
      print('Book with ISBN not found \n');
    }
    
   
  } catch (e) {
    print('An error occurred: $e');
  }
}


 
  // Search Books by title or author
  List<Book> searchBooks({String? title, String? author}) {
    return books.where((book) {
      return (title == null || book.title.contains(title)) &&
          (author == null || book.author.contains(author));
    }).toList();
  }

  
  // Add Author
  Future<void> addAuthor(Author author) async {
    final response = await http.post(
      Uri.parse('$baseUrl/authors'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(author.toJson()),
    );

    if (response.statusCode == 201) {
      authors.add(author);
      print('Author added successfully');
    } else {
      print('Failed to add author: ${response.body}');
    }
  }
  // View All Authors
  Future<List<Author>> viewAllAuthors() async {
    final response = await http.get(Uri.parse('$baseUrl/authors'));

    if (response.statusCode == 200) {
      authors = List<Author>.from(
        jsonDecode(response.body).map((data) => Author.fromJson(data))
      );
      print('Authors List:\n');
      return authors;
    } else {
      print('Failed to load authors: ${response.body}\n');
      return [];
    }
  }


  // Update Author by name
  Future<void> updateAuthor(String name, Author updatedAuthor) async {
    final response = await http.put(
      Uri.parse('$baseUrl/authors/$name'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedAuthor.toJson()),
    );

    if (response.statusCode == 200) {
      authors = authors.map((author) => author.name == name ? updatedAuthor : author).toList();
      print('Author updated successfully');
    } else {
      print('Failed to update author: ${response.body}');
    }
  }

  // Delete Author by name

Future<void> deleteAuthor(String name) async {
  try {
    // Find the author by name
    Author authorToDelete = authors.firstWhere(
      (author) => author.name == name,
      orElse: () {
        print('Author not found.');
        throw Exception('Author not found.'); // Exit early if the author is not found
      },
    );

    // Attempt to delete using the stored id
    final response = await http.delete(Uri.parse('$baseUrl/authors/${authorToDelete.id}'));

    if (response.statusCode == 200 || response.statusCode == 204) {
      authors.removeWhere((author) => author.name == name);
      print('Author deleted successfully');
    } else {
      print('Failed to delete author: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}

  // Add Member
  Future<void> addmember(Member member) async {
    final response = await http.post(
      Uri.parse('$baseUrl/members'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(member.toJson()),
    );

    if (response.statusCode == 201) {
      members.add(member);
      print('Member added successfully');
    } else {
      print('Failed to add member: ${response.body}');
    }
  }

  // View All Members
  Future<List<Member>> viewAllMembers() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/members'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);

      members = jsonResponse.map((data) => Member.fromJson(data)).toList();

      print('Members List:');
      return members;
    } else {
      print('Failed to load members: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error fetching members: $e');
    return [];
  }
}

  // Update Member by ID
   Future<void> updateMember(String memberId, Member updatedMember) async {
    final response = await http.put(
      Uri.parse('$baseUrl/members/$memberId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedMember.toJson()),
    );

    if (response.statusCode == 200) {
      members = members.map((member) => member.memberId == memberId ? updatedMember : member).toList();
      print('Member updated successfully');
    } else {
      print('Failed to update member: ${response.body}');
    }
  }

  // Delete Member by ID

Future<void> deleteMember(String memberId) async {
  try {
    // Find the member by memberId
    Member memberToDelete = members.firstWhere(
      (member) => member.memberId == memberId,
      orElse: () {
        print('Member not found.');
        throw Exception('Member not found.'); // Exit early if the member is not found
      },
    );

    // Attempt to delete using the stored _id
    final response = await http.delete(Uri.parse('$baseUrl/members/${memberToDelete.id}'));

    if (response.statusCode == 200 || response.statusCode == 204) {
      members.removeWhere((member) => member.memberId == memberId);
      print('Member deleted successfully');
    } else {
      print('Failed to delete member: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}


  // Search Members by name or ID
  List<Member> searchMembers({String? name, String? memberId}) {
    return members.where((member) {
      return (name == null || member.name.contains(name)) &&
          (memberId == null || member.memberId.contains(memberId));
    }).toList();
  }



}