import 'package:aqua_store/screen/proceedtopay.dart';
import 'package:aqua_store/services/cartservices.dart';
import 'package:aqua_store/services/rent_api.dart';
import 'package:aqua_store/utils/configs.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

void notify() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: 'Movie has been bought',
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture:
            'https://media.istockphoto.com/photos/freshwater-aquarium-in-pseudosea-style-aquascape-and-aquadesign-of-picture-id1152579000?k=20&m=1152579000&s=612x612&w=0&h=tBBlC4WwNpJw19fWE5U6czZWNK4YTS2lx_RiQY4Yi_o='),
  );
}

class _CartState extends State<Cart> {
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController country = TextEditingController();
  final GlobalKey<FormState> globalCompleteFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CartProvider>(builder: (context, value, child) {
        if (value.lst.isEmpty == true) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Cart'),
                centerTitle: true,
                backgroundColor: Colors.redAccent,
              ),
              body: const Center(
                child: Text("Empty Cart"),
              ));
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cart'),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.redAccent[700],
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.redAccent[700],
              onPressed: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: SingleChildScrollView(
                          child: Container(
                              padding: EdgeInsets.all(15),
                              child: Card(
                                  child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (input) {
                                      if (input == null || input.isEmpty) {
                                        return "Empty Address Field";
                                      } else {
                                        Container();
                                      }
                                    },
                                    controller: address,
                                    decoration: const InputDecoration(
                                      labelText: "Street Address *",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.location_on_outlined,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (input) {
                                      if (input == null || input.isEmpty) {
                                        return "Empty City ";
                                      } else {
                                        Container();
                                      }
                                    },
                                    controller: city,
                                    decoration: const InputDecoration(
                                      labelText: "City *",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.location_city_outlined,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (input) {
                                      if (input == null || input.isEmpty) {
                                        return "Please Provide Postal Code";
                                      } else {
                                        Container();
                                      }
                                    },
                                    controller: postalCode,
                                    decoration: const InputDecoration(
                                      labelText: "Postal Code *",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.qr_code_scanner_sharp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (input) {
                                      if (input == null || input.isEmpty) {
                                        return "Empty Country";
                                      } else {
                                        Container();
                                      }
                                    },
                                    controller: country,
                                    decoration: const InputDecoration(
                                      labelText: "Country *",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.flag_outlined,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await rentProduct(
                                        address.text,
                                        city.text,
                                        postalCode.text,
                                        country.text,
                                        context,
                                        data: value.lst,
                                      ).then((value) => {
                                            setState(() {
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .lst
                                                  .clear();
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            }),
                                          });
                                    },
                                    child: const Text("Buy these Items"),
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromARGB(255, 147, 40, 40),
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              )))),
                    );
                  },
                );
              },
              elevation: 5,
              icon: const Icon(Icons.done_all),
              label: const Text('Check Out'),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: value.lst.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.horizontal,
                            background: Container(
                              color: Colors.red,
                            ),
                            onDismissed: (direction) {
                              value.del(
                                index,
                              );
                            },
                            child: Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          color: Colors.red.shade100,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "${Configs.mainURL}"
                                                "/"
                                                "${value.lst[index].image}"),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 160,
                                              child: Text(
                                                value.lst[index].name
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.red[600],
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Text(
                                              "\$ Rs. ${value.lst[index].productPrice}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.red[600]),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  _gap() {
    SizedBox(
      height: 10,
    );
  }
}
