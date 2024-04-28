import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todoappvb/core/model/Product.dart';
import 'package:todoappvb/core/service.dart';
import 'package:todoappvb/ui/shared/styles/text_styles.dart';
import 'package:todoappvb/ui/shared/widgets/custom_card.dart';
import 'package:todoappvb/ui/view/add_product_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ApiService service = ApiService.getInstance();
  List<Product>? productList = [];
  final String appName = "TO DO APP";
  final String loadingUrl =
      "https://lottie.host/6d15f29c-c301-4fdc-8ade-637f62e994b0/86oBsYzMFU.json";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appName),
      ),
      floatingActionButton: _fabButton,
      body: FutureBuilder<List<Product>>(
        future: service.getProducts(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                productList = snapshot.data;
                return _listView;
              }
              return const Center(
                child: Text(
                  "All tasks are done!",
                  style: titleStyle,
                ),
              );
            default:
              return Center(
                child: LottieBuilder.network(loadingUrl),
              );
          }
        },
      ),
    );
  }

  Widget get _listView => ListView.builder(
      itemCount: productList!.length,
      itemBuilder: (context, index) => dismiss(
          CustomCard(
            title: productList![index].productName ?? "",
            subtitle: "${productList![index].money}",
            imageUrl: productList![index].imageUrl ?? "",
          ),
          productList![index].key ?? ""));

  Widget dismiss(Widget child, String key) {
    return Dismissible(
      key: UniqueKey(),
      secondaryBackground: const Center(
        child: Text("Deleted"),
      ),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (dismissDirection) async {
        await service.removeProducts(key);
      },
      child: child,
    );
  }

  Widget get _fabButton => FloatingActionButton(
        onPressed: fabPressed,
        child: const Icon(Icons.add),
      );

  void fabPressed() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        context: context,
        builder: (context) => bottomSheet);
  }

  Widget get bottomSheet => SizedBox(
        height: 100,
        child: Column(
          children: <Widget>[
            const Divider(
              thickness: 2,
              indent: 100,
              endIndent: 100,
              color: Colors.grey,
            ),
            ElevatedButton(
              child: const Text("Add Task"),
              onPressed: () {
                Navigator.pop(context);

                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text(
                            "Add New Task",
                            style: titleStyle,
                          ),
                          content: AddProductView(),
                        ));
                /* Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddProductView())); */
              },
            )
          ],
        ),
      );
}
