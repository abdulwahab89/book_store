import 'dart:ui';

import 'package:book_store/book_list.dart';
import 'package:book_store/book_provider.dart';
import 'package:book_store/db_helper.dart';
import 'package:flutter/material.dart';
import 'dart_model.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<BookProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<BookModel>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: Image(
                              image: NetworkImage(
                                  'https://cdni.iconscout.com/illustration/premium/thumb/empty-cart-4816550-4004141.png')),
                        ),
                        const Text(
                          'Looks like you haven'
                          r't added anything to your cart',
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const BookList()));
                            },
                            child: const Text(
                              'Explore now',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              selectionColor: Colors.lightBlue,
                            ))
                      ],
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
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
                                          image: NetworkImage(snapshot
                                              .data![index].image
                                              .toString()),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index].productName
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    dbHelper.delete(snapshot
                                                        .data![index].id!);
                                                    cart.removeCounter();
                                                    cart.removeTotalPrice(
                                                        snapshot.data![index]
                                                            .productPrice!
                                                            .toDouble());
                                                  },
                                                  child: const Icon(
                                                      Icons.delete_outlined))
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text("Price: " +
                                              r"$" +
                                              snapshot.data![index].initialPrice
                                                  .toString()),
                                          const SizedBox(height: 50),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Center(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors
                                                          .yellow.shade700,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    height: 35,
                                                    width: 80,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            int quantity =
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .quantity!;
                                                            if (quantity > 1) {
                                                              int price = snapshot
                                                                  .data![index]
                                                                  .initialPrice!;
                                                              quantity--;
                                                              int newPrice =
                                                                  quantity *
                                                                      price;
                                                              dbHelper
                                                                  .update(
                                                                      BookModel(
                                                                id: index,
                                                                productPrice:
                                                                    newPrice,
                                                                productName: snapshot
                                                                    .data![
                                                                        index]
                                                                    .productName,
                                                                productId: index
                                                                    .toString(),
                                                                initialPrice: snapshot
                                                                    .data![
                                                                        index]
                                                                    .initialPrice,
                                                                quantity:
                                                                    quantity,
                                                                productAuthor:
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .productAuthor,
                                                                image: snapshot
                                                                    .data![
                                                                        index]
                                                                    .image,
                                                              ))
                                                                  .then(
                                                                      (value) {
                                                                cart.removeTotalPrice(snapshot
                                                                    .data![
                                                                        index]
                                                                    .initialPrice!
                                                                    .toDouble());
                                                                quantity = 0;
                                                                newPrice = 0;
                                                              });
                                                            }
                                                          },
                                                          child: const Icon(
                                                            Icons.remove,
                                                          ),
                                                        ),
                                                        Text(snapshot
                                                            .data![index]
                                                            .quantity
                                                            .toString()),
                                                        InkWell(
                                                          onTap: () {
                                                            int quantity =
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .quantity!;

                                                            int price = snapshot
                                                                .data![index]
                                                                .initialPrice!;
                                                            quantity++;
                                                            int newPrice =
                                                                quantity *
                                                                    price;
                                                            dbHelper
                                                                .update(
                                                                    BookModel(
                                                              id: index,
                                                              productPrice:
                                                                  newPrice,
                                                              productName: snapshot
                                                                  .data![index]
                                                                  .productName,
                                                              productId: index
                                                                  .toString(),
                                                              initialPrice: snapshot
                                                                  .data![index]
                                                                  .initialPrice,
                                                              quantity:
                                                                  quantity,
                                                              productAuthor:
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .productAuthor,
                                                              image: snapshot
                                                                  .data![index]
                                                                  .image,
                                                            ))
                                                                .then((value) {
                                                              cart.addTotalPrice(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .initialPrice!
                                                                      .toDouble());

                                                              quantity = 0;
                                                              newPrice = 0;
                                                            });
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                        text: snapshot
                                            .data![index].productAuthor
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: 'Satisfy',
                                          color: Colors.grey.shade900,
                                        )),
                                  ],
                                )),
                              ],
                            ),
                          );
                        }),
                  );
                }

                return const Center();
              }),
          Consumer<BookProvider>(builder: (context, value, child) {
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2) == '0.00'
                  ? false
                  : true,
              child: Column(
                children: [
                  ReusableCard(
                      title: 'Sub Total',
                      value: r'$' + value.getTotalPrice().toStringAsFixed(2))
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  String title, value;
  ReusableCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: Colors.orangeAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            title.toString() + " =",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            r"$" + value.toString(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
