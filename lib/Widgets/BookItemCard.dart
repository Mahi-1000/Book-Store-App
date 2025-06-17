import 'package:bookstoreapp/Models/book.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp/Screens/BookDetailScreen.dart';

class BookItemCard extends StatelessWidget {
  final Book book;
  // final int bookId;
  const BookItemCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => 
              BookDetailScreen(bookId: book.id!, book:book),
          ),
        );
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Cover Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  book.coverPageUrl,
                  height: 120,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),

              // Book Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'by ${book.author}',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      book.desc,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Chip(
                          label: Text(book.genre),
                          backgroundColor: Colors.blue.shade50,
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        Text('${book.rating}'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}