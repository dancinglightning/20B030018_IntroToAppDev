import 'package:catalog_app/services/Database.dart';
import 'package:catalog_app/services/product_notifier.dart';
import 'package:catalog_app/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDisplay extends StatefulWidget {


  @override
  _ProductDisplayState createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  @override
  void initState() {
    ProductNotifier productNotifier=Provider.of<ProductNotifier>(context, listen: false);
    getProducts(productNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier=Provider.of<ProductNotifier>(context);
    return Container(
        child: Scaffold(
          body: SafeArea(
            child: Container(
              padding: Vx.m32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Featured Products".text.xl5.bold.color(ColorMe.cadetgrey)
                      .make(),
                  // "Trending".text.xl2.make(),
                  //TODO firebase data null check
                  
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Image.network(productNotifier.productList[index].imgUrl),

                              title: Text(productNotifier.productList[index].title),
                              subtitle: Text(
                                  "by  ${productNotifier.productList[index].name}"),
                              trailing: Text("₹ ${productNotifier.productList[index].price}"),
                            );
                          }, separatorBuilder: (BuildContext context, int index) {
                        return Divider(color: Colors.deepOrangeAccent,);
                      }, itemCount: productNotifier.productList.length),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      );
    }

}

// class ProductList extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 5,
//         itemBuilder: (context,index){
//         // final catalog
//         // return ProductItem(catalog);
//         // });
//   }
// }

