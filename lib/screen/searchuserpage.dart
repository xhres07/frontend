import 'package:aqua_store/model/product.dart';
import 'package:aqua_store/screen/productuserdetail.dart';
import 'package:aqua_store/services/searchProduct_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchUserPage extends StatefulWidget {
  SearchUserPage({Key? key}) : super(key: key);

  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  List<ProductElement>? products;
  TextEditingController searchP = TextEditingController();
  String query = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<SearchProduct>(
          builder: (context, search, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextField(
                              controller: searchP,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: "Search . . .",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black54, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              search.getProduct(
                                searchP.text,
                                context,
                              );
                            },
                            icon: const Icon(Icons.search),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      if (search.value?.isEmpty == true) ...{
                        Container(),
                      } else ...{
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: search.value?.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductUserDetail(
                                              id: (search.value?[index].id)
                                                  .toString(),
                                              name: (search.value?[index].name)
                                                  .toString(),
                                              image:
                                                  (search.value?[index].image)
                                                      .toString(),
                                              category: (search
                                                      .value?[index].category)
                                                  .toString(),
                                              price:
                                                  (search.value?[index].price)!
                                                      .toInt(),
                                              description: (search.value?[index]
                                                      .description)
                                                  .toString(),
                                              productid:
                                                  (search.value?[index].id)
                                                      .toString(),
                                              stock: ((search.value?[index]
                                                      .countInStock)
                                                  .toString()),
                                            )),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: ListTile(
                                        title: Text(
                                          (search.value?[index].name)
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.redAccent[700],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      }
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
