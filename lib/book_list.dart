import 'dart:async';

import 'package:book_store/book_provider.dart';
import 'package:book_store/cart_screen.dart';
import 'package:book_store/dart_model.dart';
import 'package:book_store/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class BookList extends StatefulWidget {
  const BookList({Key? key}) : super(key: key);
  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70, 90, 66, 43];
  List<String> bookAuthor = [
    "Khaled Hosseini",
    "Mark Manson",
    "James Clear",
    "Harper Lee",
    "J.K Rowling",
    "Elif Shafak",
    "Carl Sagan",
    "Conan Doyle",
    "Stephen Hawking",
    "Joshua Foer",
  ];
  List<String> bookNames = [
    "A thousand\nsplendid Suns",
    "The subtle art \nof not giving\n a fuck",
    "Atomic Habits",
    "To kill\na mocking bird",
    "Harry Potter\n S1",
    "The forty\nrules of love",
    "Cosmos",
    "A study in scarlet",
    "The great design",
    "Moonwalking\n with Einstein",
  ];

  List<String> bookCovers = [
    "https://www.libertybooks.com/image/cache/catalog/9781526604767-8-313x487.jpg?q6",
    "https://www.libertybooks.com/image/cache/catalog/fuck-640x996.jpg?q6",
    "https://images.squarespace-cdn.com/content/v1/5e34962e0a9a7332891cac30/1591399219133-0CSBL3BQS1TA2WE5ZWV1/Screen+Shot+2020-06-05+at+4.11.57+PM.png?format=1000w",
    "https://m.media-amazon.com/images/M/MV5BNmVmYzcwNzMtMWM1NS00MWIyLThlMDEtYzUwZDgzODE1NmE2XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg", //tokillmockingbird
    "https://res.cloudinary.com/bloomsbury-atlas/image/upload/w_360,c_scale/jackets/9781408855652.jpg", //hp
    "https://kbimages1-a.akamaihd.net/4e1e8de5-d6ab-4d23-9509-31c0f1e8b96e/353/569/90/False/the-forty-rules-of-love.jpg", //fol
    "https://www.libertybooks.com/image/cache/catalog/9780349107035-640x996.jpg?q6", //cosmos
    "https://m.media-amazon.com/images/I/41jNoiUgf3L.jpg", //studyinscarlet
    "https://upload.wikimedia.org/wikipedia/en/1/10/The_grand_design_book_cover.jpg",
    "https://kbimages1-a.akamaihd.net/6c5ec830-036d-4d17-a7f4-67cb981f493c/353/569/90/False/moonwalking-with-einstein.jpg", //mw
  ];

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<BookProvider>(context);
    DBHelper dbHelper = DBHelper();
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Center(
              child: badges.Badge(
                badgeContent: Consumer<BookProvider>(
                  builder: (context, value, child) {
                    return Text(
                      value.getCounter().toString(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
        iconTheme: const IconThemeData(
          color: Colors.red,
        ),
        backgroundColor: const Color(0xffC4E7ED),
        centerTitle: true,
        title: const Text(
          'Book List',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Satisfy',
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              height: 40,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: textEditingController,
                decoration: InputDecoration(
                    fillColor: Colors.white70,
                    prefixIcon: Icon(Icons.search),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    hintText: 'Search a book',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: bookCovers.length,
                itemBuilder: (context, index) {
                  String name = bookNames[index];
                  if (textEditingController.text.isEmpty) {
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 150,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        bookCovers[index].toString()),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bookNames[index].toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text("Price: " +
                                        r"$" +
                                        productPrice[index].toString()),
                                    const SizedBox(height: 50),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            dbHelper
                                                .insert(BookModel(
                                                    id: index,
                                                    productPrice:
                                                        productPrice[index],
                                                    productName:
                                                        bookNames[index]
                                                            .toString(),
                                                    productAuthor:
                                                        bookAuthor[index]
                                                            .toString(),
                                                    quantity: 1,
                                                    initialPrice:
                                                        productPrice[index],
                                                    image: bookCovers[index]
                                                        .toString(),
                                                    productId:
                                                        index.toString()))
                                                .then((value) {
                                              cart.addTotalPrice(
                                                  productPrice[index]
                                                      .toDouble());
                                              cart.addCounter();
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xffC4E7ED),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            height: 35,
                                            width: 300,
                                            child: const Center(
                                                child: Text(
                                              'Add to cart',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          RichText(
                              text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Author: ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                  text: bookAuthor[index].toString(),
                                  style: TextStyle(
                                    fontFamily: 'Satisfy',
                                    color: Colors.grey.shade900,
                                  )),
                            ],
                          ))
                        ],
                      ),
                    );
                  } else if (name
                      .toLowerCase()
                      .contains(textEditingController.text.toLowerCase())) {
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 150,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        bookCovers[index].toString()),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bookNames[index].toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text("Price: " +
                                        r"$" +
                                        productPrice[index].toString()),
                                    const SizedBox(height: 50),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            dbHelper
                                                .insert(BookModel(
                                                    id: index,
                                                    productPrice:
                                                        productPrice[index],
                                                    productName:
                                                        bookNames[index]
                                                            .toString(),
                                                    productAuthor:
                                                        bookAuthor[index]
                                                            .toString(),
                                                    quantity: 1,
                                                    initialPrice:
                                                        productPrice[index],
                                                    image: bookCovers[index]
                                                        .toString(),
                                                    productId:
                                                        index.toString()))
                                                .then((value) {
                                              cart.addTotalPrice(
                                                  productPrice[index]
                                                      .toDouble());
                                              cart.addCounter();
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xffC4E7ED),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            height: 35,
                                            width: 300,
                                            child: const Center(
                                                child: Text(
                                              'Add to cart',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          RichText(
                              text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Author: ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                  text: bookAuthor[index].toString(),
                                  style: TextStyle(
                                    fontFamily: 'Satisfy',
                                    color: Colors.grey.shade900,
                                  )),
                            ],
                          ))
                        ],
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
