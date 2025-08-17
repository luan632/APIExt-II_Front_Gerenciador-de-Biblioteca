class Book {
  final String id;
  final String title;
  final String author;
  final String isbn;
  final int publicationYear;
  final String publisher;
  final int quantity;
  final String? coverUrl;
  final bool isDigital;
  final String? digitalUrl;
  final List<String> categories;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.isbn,
    required this.publicationYear,
    required this.publisher,
    required this.quantity,
    this.coverUrl,
    required this.isDigital,
    this.digitalUrl,
    required this.categories,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      isbn: map['isbn'],
      publicationYear: map['publicationYear'],
      publisher: map['publisher'],
      quantity: map['quantity'],
      coverUrl: map['coverUrl'],
      isDigital: map['isDigital'],
      digitalUrl: map['digitalUrl'],
      categories: List<String>.from(map['categories']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'isbn': isbn,
      'publicationYear': publicationYear,
      'publisher': publisher,
      'quantity': quantity,
      'coverUrl': coverUrl,
      'isDigital': isDigital,
      'digitalUrl': digitalUrl,
      'categories': categories,
    };
  }
}