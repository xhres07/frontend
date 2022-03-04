import 'package:aqua_store/admin/add_product.dart';
import 'package:aqua_store/admin/product_details.dart';
import 'package:aqua_store/admin/search_page.dart';
import 'package:aqua_store/admin/update_product_scree.dart';
import 'package:aqua_store/admin/view_my_order.dart';
import 'package:aqua_store/admin/view_order.dart';
import 'package:aqua_store/model/product.dart';
import 'package:aqua_store/screen/login_screen.dart';
import 'package:aqua_store/services/delete_product_api.dart';
import 'package:aqua_store/services/product_service.dart';
import 'package:aqua_store/services/searchProduct_api.dart';
import 'package:aqua_store/utils/configs.dart';
import 'package:aqua_store/utils/search.dart';
import 'package:aqua_store/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<MyProduct>(context, listen: false).getproduct(context);
  }

  late List<ProductElement>? products;
  String query = '';
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        child: ListView(
          shrinkWrap: true,
          children: [
            DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage("assets/logo.png"))),
                child: Stack(children: const [])),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              color: Colors.redAccent[700],
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  primary: Colors.redAccent[700],
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddProductUi()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Add Product",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.redAccent,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              color: Colors.redAccent[700],
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  primary: Colors.redAccent[700],
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ViewAdminOrders()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "View All Orders",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.redAccent,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              color: Colors.redAccent[700],
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  primary: Colors.redAccent[700],
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ViewMyOrder()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_red_eye_sharp,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "View My Order",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.redAccent,
              thickness: 1,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(15),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  SharedServices.logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()),
                    (route) => false,
                  );
                  Fluttertoast.showToast(
                    msg: "Successfully Logged Out",
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: 12,
                    textColor: Colors.black,
                    backgroundColor: Colors.grey[100],
                  );
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.redAccent[700],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: const Text(
          "Admin Dashboard",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          )
        ],
      ),
      body: Consumer<MyProduct>(builder: (context, product, child) {
        if (product.value?.isEmpty == true) {
          return Center(
              child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(20), child: const Text("Empty")),
          ));
        } else {
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Colors.redAccent.shade700,
                    Colors.redAccent,
                  ])),
              child: Container(
                margin: const EdgeInsets.all(15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0,
                    ),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: product.value?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GridTile(
                        child: InkWell(
                          onTap: () {
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                          id: (product.value?[index].id)
                                              .toString(),
                                          name: (product.value?[index].name)
                                              .toString(),
                                          image: (product.value?[index].image)
                                              .toString(),
                                          category:
                                              (product.value?[index].category)
                                                  .toString(),
                                          price: (product.value?[index].price)!
                                              .toInt(),
                                          description: (product
                                                  .value?[index].description)
                                              .toString(),
                                          productid: (product.value?[index].id)
                                              .toString(),
                                          stock: ((product
                                                  .value?[index].countInStock)
                                              .toString()),
                                        )),
                              );
                            }
                          },
                          child: Card(
                            elevation: 10,
                            child: Container(
                              height: 130,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.purple.shade100,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(Configs.mainURL +
                                      "/uploads/" +
                                      "${product.value?[index].image}"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        footer: Column(
                          children: [
                            Text((product.value?[index].name).toString(),
                                style: TextStyle(
                                    color: Colors.redAccent[700],
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            space(),
                            Text(
                                "\$: ${(product.value?[index].price).toString()}",
                                style: TextStyle(
                                    color: Colors.redAccent[700],
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            space(),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          );
        }
      }),
    );
  }

  SizedBox space() {
    return const SizedBox(
      height: 5,
    );
  }
}
