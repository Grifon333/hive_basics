import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 1)
class Book extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  int count_pages;
  @HiveField(2)
  String author;

  Book(
      this.title,
      this.count_pages,
      this.author
      );

  @override
  String toString() {
    return 'Book{title: $title, count_pages: $count_pages, author: $author}';
  }
}