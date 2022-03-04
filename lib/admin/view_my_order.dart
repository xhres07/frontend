import 'package:aqua_store/services/view_my_order_services.dart';
import 'package:aqua_store/utils/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewMyOrder extends StatefulWidget {
  ViewMyOrder({Key? key}) : super(key: key);

  @override
  State<ViewMyOrder> createState() => _ViewMyOrderState();
}

class _ViewMyOrderState extends State<ViewMyOrder> {
  @override
  void initState() {
    super.initState();
    Provider.of<ViewMyOrders>(context, listen: false).viewOrder(context);
  }

  @override
  Widget build(BuildContext context) {
    final timeDate = Provider.of<TimeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("View All Movie Orders"),
        backgroundColor: Colors.redAccent[700],
        centerTitle: true,
        elevation: 2,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<ViewMyOrders>(builder: (context, value, child) {
        if (value.value?.isEmpty == true) {
          return Center(
              child: Container(
                  margin: const EdgeInsets.all(20),
                  child: const Text(
                    "Empty",
                    style: TextStyle(fontSize: 20),
                  )));
        } else {
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Colors.green.shade100,
                    Colors.green.shade50,
                  ])),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    color: Colors.redAccent[700],
                    child: const Text(
                      "Here are the list of orders you have done so far.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
                ...value.value!.map(
                  (e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        color: Colors.redAccent[700],
                                        child: const Text(
                                          "Picking Address",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Street Location : ${(e.shippingAddress?.address).toString()}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.redAccent[700],
                                        ),
                                      ),
                                      Text(
                                        "City : ${(e.shippingAddress?.city).toString()}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.redAccent[700],
                                        ),
                                      ),
                                      Text(
                                        "Country : ${(e.shippingAddress?.country).toString()}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.redAccent[700],
                                        ),
                                      ),
                                      Text(
                                        "Postal Code : ${(e.shippingAddress?.postalCode).toString()}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.redAccent[700],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.redAccent[700],
                                        thickness: 2,
                                      ),
                                      Container(
                                        color: Colors.redAccent[700],
                                        padding: EdgeInsets.all(8),
                                        child: const Text(
                                          "Items Bought",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      for (var data in e.orderItems!)
                                        Column(
                                          children: [
                                            Text(
                                              (data.name).toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.redAccent[700]),
                                            ),
                                            Text(
                                              "Price \$:${(data.price).toString()}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.red[600]),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            )
                                          ],
                                        ),
                                      Divider(
                                        color: Colors.redAccent[700],
                                        thickness: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                )
              ]),
            ),
          );
        }
      }),
    );
  }
}
