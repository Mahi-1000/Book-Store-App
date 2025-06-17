import 'package:bookstoreapp/Models/book.dart';
import 'package:bookstoreapp/Screens/BookAddScreen.dart';
import 'package:bookstoreapp/Services/BookRemoteServices.dart';
import 'package:bookstoreapp/Widgets/BookItemCard.dart';
import 'package:flutter/material.dart';

class Bookhomescreen extends StatefulWidget {
  @override
  State<Bookhomescreen> createState() => _BookhomescreenState();
}

class _BookhomescreenState extends State<Bookhomescreen> {
  List<Book>? allBook = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    allBook = await Bookremoteservices().getAllBooks();
    if (allBook != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BOOK STORE APP')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => BookAddScreen()));
          
        },
        child: Icon(Icons.add),
      ),
       body: Visibility(
        visible: isLoaded,
        replacement: Center(child: CircularProgressIndicator(),),
        child: ListView.builder(
          itemCount: allBook!.length,
          itemBuilder: (context, index) => BookItemCard(book: allBook![index]),
        ),
      ),
    );
  }
}