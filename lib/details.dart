//MEMBERS CLASS

class Book {
  String id; // Add this line
  String title;
  String author;
  int publishedYear;
  String isbn;
  bool isLent;
  String dueDate;

  // Constructor
  Book(this.title, this.author, this.publishedYear, this.isbn,
      {this.isLent = false, this.dueDate = '', this.id = ''});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'publishedYear': publishedYear,
      'isbn': isbn,
      'isLent': isLent,
      'dueDate': dueDate,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      json['title'] ?? '',
      json['author'] ?? '',
      json['publishedYear'] ?? 0,
      json['isbn'] ?? '',
      isLent: json['isLent'] ?? false,
      dueDate: json['dueDate'] ?? '',
      id: json['id'] ?? '', // Retrieve _id from the response
    );
  }
}



class Author {
  String id; // Add this line
  String name;
  List<String> booksWritten;

  Author(this.name, this.booksWritten, {this.id = ''});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'booksWritten': booksWritten,
    };
  }

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      json['name'],
      List<String>.from(json['booksWritten']),
      id: json['id'] ?? '', // Retrieve _id from the response
    );
  }
}


class Member {
  String id; // Add this line
  String name;
  String memberId;
  List<String> borrowedBooks;

  Member(this.name, this.memberId, this.borrowedBooks, {this.id = ''});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'memberId': memberId,
      'borrowedBooks': borrowedBooks,
    };
  }

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      json['name'],
      json['memberId'],
      List<String>.from(json['borrowedBooks']),
      id: json['id'] ?? '', // Retrieve _id from the response
    );
  }
}
