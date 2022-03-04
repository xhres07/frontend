import 'dart:io';
import 'package:aqua_store/admin/admin_home.dart';
import 'package:aqua_store/admin/update_product_scree.dart';
import 'package:aqua_store/services/product_service.dart';
import 'package:aqua_store/services/rent_api.dart';
import 'package:aqua_store/services/searchProduct_api.dart';
import 'package:aqua_store/utils/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final String id;
  final String name;
  final dynamic image;
  final String category;
  final int price;
  final String description;
  final String productid;
  final String stock;

  const ProductDetail({
    Key? key,
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.productid,
    required this.image,
    required this.stock,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final address = TextEditingController();
  final city = TextEditingController();
  final postalCode = TextEditingController();
  final country = TextEditingController();
  TextEditingController dateInText = TextEditingController();
  TextEditingController dateOutText = TextEditingController();
  final GlobalKey<FormState> globalCompleteFormKey = GlobalKey<FormState>();

  DateTimeRange? dateRange;
  String getFrom() {
    if (dateRange == null) {
      return "Select Rent Date From";
    } else {
      return DateFormat("yyyy-MM-dd").format(dateRange!.start);
    }
  }

  String getTo() {
    if (dateRange == null) {
      return ("Until *");
    } else {
      return DateFormat("yyyy-MM-dd").format(dateRange!.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeDate = Provider.of<TimeProvider>(context);
    DateTime selectedDateFrom = DateTime.now();
    DateTime selectedDateTo = DateTime.now().add(const Duration(days: 7));
    String durationFrom = timeDate.getDate((selectedDateFrom).toString());
    String durationTo = timeDate.getDate((selectedDateTo).toString());

    Future pickDateRange(BuildContext context) async {
      final initialDateRange = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 24 * 7)),
      );
      final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: dateRange ?? initialDateRange,
      );
      if (newDateRange == null) return;
      setState(() {
        dateRange = newDateRange;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 196, 12, 12),
        title: const Text("Details"),
        centerTitle: true,
      ),
      body: Consumer<MyProduct>(
        builder: (context, product, child) {
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(8),
              child: Card(
                elevation: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          gap(),
                          Container(
                            height: 200,
                            color: Colors.redAccent,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                gap(),
                                Text("Movie Name : ${widget.name}",
                                    style: TextStyle(
                                      color: Colors.redAccent[700],
                                      fontSize: 16,
                                    )),
                                gap(),
                                Text("Category: ${widget.category}",
                                    style: TextStyle(
                                      color: Colors.redAccent[700],
                                      fontSize: 16,
                                    )),
                                gap(),
                                Text("Prices \$: ${widget.price}",
                                    style: TextStyle(
                                      color: Colors.redAccent[700],
                                      fontSize: 16,
                                    )),
                                gap(),
                                Text("Total Available Movies: ${widget.stock}",
                                    style: TextStyle(
                                      color: Colors.redAccent[700],
                                      fontSize: 16,
                                    )),
                                gap(),
                                Text("Description: ${widget.description}",
                                    style: TextStyle(
                                      color: Colors.redAccent[700],
                                      fontSize: 16,
                                    )),
                                gap(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            product
                                                .delproduct(
                                                  widget.id,
                                                  context,
                                                )
                                                .then((value) => {
                                                      if (value.message ==
                                                          "Product Removed")
                                                        {
                                                          Navigator.pop(
                                                              context),
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                "Product Successfully Removed",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            fontSize: 20.0,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            textColor:
                                                                Colors.white,
                                                            backgroundColor:
                                                                Colors.redAccent[
                                                                    700],
                                                          ),
                                                        }
                                                    });
                                          },
                                          child: const Text("Delete"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.redAccent[700],
                                              textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateProductUi(
                                                  id: widget.id,
                                                  name: widget.name,
                                                  category: widget.category,
                                                  description:
                                                      widget.description,
                                                  stock: widget.stock,
                                                  price:
                                                      widget.price.toString(),
                                                  image: widget.image,
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text("Update"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.redAccent[700],
                                              textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    gap(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox gap() {
    return const SizedBox(
      height: 20,
    );
  }
}
