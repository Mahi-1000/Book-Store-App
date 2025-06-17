import 'package:bookstoreapp/Models/book.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:bookstoreapp/Services/BookRemoteServices.dart';

class Bookupdatescreen extends StatefulWidget {

  final Book book;
  const Bookupdatescreen({super.key, required this.book});
  @override
  State<Bookupdatescreen> createState() => _BookupdatescreenState();
}

class _BookupdatescreenState extends State<Bookupdatescreen> {
 final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _addedByController;
  late TextEditingController _descController;
  late TextEditingController _coverUrlController;
  late TextEditingController _yearController;
  late TextEditingController _genreController;
  late TextEditingController _languageController;
  late TextEditingController _pagesController;
  late TextEditingController _publisherController;
  late TextEditingController _ratingController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.author);
    _addedByController = TextEditingController(text: widget.book.addedBy);
    _descController = TextEditingController(text: widget.book.desc);
    _coverUrlController = TextEditingController(text: widget.book.coverPageUrl);
    _yearController = TextEditingController(text: widget.book.year.toString());
    _genreController = TextEditingController(text: widget.book.genre);
    _languageController = TextEditingController(text: widget.book.language);
    _pagesController = TextEditingController(text: widget.book.pages.toString());
    _publisherController = TextEditingController(text: widget.book.publisher);
    _ratingController = TextEditingController(text: widget.book.rating.toString());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _addedByController.dispose();
    _descController.dispose();
    _coverUrlController.dispose();
    _yearController.dispose();
    _genreController.dispose();
    _languageController.dispose();
    _pagesController.dispose();
    _publisherController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  void _submitUpdate() {
    if (_formKey.currentState!.validate()) {
      Book updatedBook = Book(
        id: widget.book.id,
        author: _authorController.text.trim(),
        addedBy: _addedByController.text.trim(),
        title: _titleController.text.trim(),
        desc: _descController.text.trim(),
        coverPageUrl: _coverUrlController.text.trim(),
        year: int.tryParse(_yearController.text.trim()) ?? 0,
        genre: _genreController.text.trim(),
        language: _languageController.text.trim(),
        pages: int.tryParse(_pagesController.text.trim()) ?? 0,
        publisher: _publisherController.text.trim(),
        rating: double.tryParse(_ratingController.text.trim()) ?? 0,
      );

      _updateBook(updatedBook);
    }
  }

  Future<void> _updateBook(Book book) async {
    bool status = true;
    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Book updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    // ignore: dead_code
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update book!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Book"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(_titleController, "Title"),
              _buildTextField(_authorController, "Author"),
              _buildTextField(_addedByController, "Added By"),
              _buildTextField(_descController, "Description", maxLines: 3),
              _buildTextField(_coverUrlController, "Cover Page URL"),
              _buildTextField(_yearController, "Year", isNumber: true),
              _buildTextField(_genreController, "Genre"),
              _buildTextField(_languageController, "Language"),
              _buildTextField(_pagesController, 'Total Pages', isNumber: true),
              _buildTextField(_publisherController, 'Publisher'),
              _buildTextField(_ratingController, 'Ratings', isNumber: true),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submitUpdate,
                icon: const Icon(Icons.update),
                label: const Text("Update"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}