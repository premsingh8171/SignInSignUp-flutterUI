import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'apifunction/apifunction.dart';
import 'constant/constfile.dart';
import 'model/apiobject.dart';



class Dashboard extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    //  appBar: AppBar(title: Text("Product Listing")),
      body: MyHomePage(title: "Product Listing"),
    );
    /*return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo', theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
      home: MyHomePage(title: 'Product layout demo home page', ),
    );*/
  }
}


class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Product Listing")),
        body: FutureBuilder<List<ApiObject>>(
            future: fetchApiObjects(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data found.'));
              }else {
                final objects = snapshot.data!;

                return ListView.builder(
                  itemCount: objects.length,
                  itemBuilder: (context, index){
                    final obj = objects[index];
                    return ProductBox(
                        name: obj.name,
                        description: obj.data?['color']?.toString() ?? 'No description',
                        price: 1000,
                        image: "boy.png"
                    );
                  },
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
                  //children: <Widget>[

                  /* ProductBox(
                      name: "Pixel",
                      description: "Pixel is the most featureful phone ever",
                      price: 800,
                      image: "boy.png"
                  ),
                  ProductBox(
                      name: "Laptop",
                      description: "Laptop is most productive development tool",
                      price: 2000,
                      image: "boy.png"
                  ),
                  ProductBox(
                      name: "Tablet",
                      description: "Tablet is the most useful device ever for meeting",
                      price: 1500,
                      image: "boy.png"
                  ),
                  ProductBox(
                      name: "Pendrive",
                      description: "Pendrive is useful storage medium",
                      price: 100,
                      image: "boy.png"
                  ),
                  ProductBox(
                      name: "Floppy Drive",
                      description: "Floppy drive is useful rescue storage medium",
                      price: 20,
                      image: "boy.png"
                  ),*/
                  //],
                );
              }
            }
        )
    );
  }
}


class ProductBox extends StatelessWidget {
  ProductBox({Key? key, required this.name, required this.description, required this.price, required this.image}) :
        super(key: key);
  final String name;
  final String description;
  final int price;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        String name = this.name.toString();
        // For example, print it to console
        print("Clicked item data: $name");
        Fluttertoast.showToast(
          msg: "Clicked: ${name}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyCustomDialog(
              title: 'Name: $name',
              content: 'This is the dialog content. for $description',
            );
          },
        );
        // You can also perform navigation or other actions here
      },
      child: Container(
        padding: EdgeInsets.all(2),
        height: 120,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Text section first (left side)
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                    crossAxisAlignment: CrossAxisAlignment.start, // Align left
                    children: <Widget>[
                      Text(
                        this.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8), // Add spacing between texts
                      Text(this.description),
                      SizedBox(height: 8),
                      Text("Price: ${this.price}"),
                    ],
                  ),
                ),
              ),
              // Image section (right side)
              Image.asset(
                "assets/$image",
                height: 80, // Optional: set image height
                width: 80,  // Optional: set image width
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }

/*
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 120,
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset("assets/$image"),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                  this.name, style: TextStyle(
                                  fontWeight: FontWeight.bold
                              )
                              ),
                              Text(this.description), Text(
                                  "Price: ${this.price}"
                              ),
                            ],
                          )
                      )
                  )
                ]
            )
        )
    );
  }
*/


}