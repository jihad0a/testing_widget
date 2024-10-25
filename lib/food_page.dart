import 'package:flutter/material.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Menu'),
        centerTitle: true,
        backgroundColor: Colors.white60,
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 1,
          children: [
            productCard("Pizza Hot", '10.00', '4.5', 'assets/pizza.png'),
            productCard("Delicious Burger", '7.5', '5.0', 'assets/burger.png'),
            productCard("Fries Combo", '5.5', '4.2', 'assets/fries.png'),
            productCard("Chicken Wings", '6.8', '4.8', 'assets/wings.png'),
            productCard("Sushi Special", '10.5', '4.9', 'assets/sushi.png'),
            productCard("Pasta Delight", '9.0', '4.7', 'assets/pasta.png'),
          ],
        ),
      ),
    );
  }
}

class ProductCardState extends StatefulWidget {
  final String title;
  final String price;
  final String rating;
  final String imagePath;

  const ProductCardState(
      {required this.title,
        required this.price,
        required this.rating,
        required this.imagePath,
        super.key});

  @override
  State<ProductCardState> createState() => _ProductCardStateState();
}

class _ProductCardStateState extends State<ProductCardState> {
  bool favorite = false;
  bool buy = false;
  bool details = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                widget.imagePath, height: 70, width: 90, fit: BoxFit.cover,),
              const SizedBox(height: 2,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title, style: const TextStyle(
                      fontWeight: FontWeight.bold),),
                  const SizedBox(height: 2,),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_border_purple500_sharp,
                        color: Colors.amber,
                        size: 16,),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(widget.rating, style: const TextStyle(
                          fontWeight: FontWeight.bold),),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "\$${widget.price}",
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          right: 1,
          top: 1,
          child: IconButton(
              onPressed: () {
                setState(() {
                  favorite = !favorite;
                });
              },
              icon: Icon(
                favorite ? Icons.favorite_border_sharp : Icons.favorite,
                color: favorite ? Colors.black : Colors.red,
                size: favorite ? 25 : 25,
              )),
        ),
      Positioned(
        right: 1,
        bottom: 6,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(
                  side: BorderSide(
                      width: 1,
                      color: Colors.black,
                      style: BorderStyle.solid))),
          onPressed: () {
            setState(() {
              buy = false;
            });
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Buying The ${widget.title}?'),
                    content: const Text("Are you Sure?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              buy = true;
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('${widget.title} Purchased!')));
                          },
                          child: const Text('Buy'))
                    ],
                  );
                });
          },
          child: Icon(
            buy ? Icons.download_done : Icons.shopping_cart,
            color: buy ? Colors.green : Colors.deepPurpleAccent,
            size: buy ? 25 : 25,
          ),
        ),
      ),
        Positioned(
          bottom: 6,
          right: 44,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(
                    side: BorderSide(
                        width: 1,
                        color: Colors.black,
                        style: BorderStyle.solid))),
            onPressed: () {
              setState(() {
                details = true;
              });
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Details of '${widget.title}'"),
                      content: Text("The Price is '${widget.price}'\n"
                          "The Rating is '${widget.rating}'"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close')),
                      ],
                    );
                  }).then((_) {
                setState(() {
                  details = false;
                });
              });
            },
            child: Icon(
              details ? Icons.info_sharp : Icons.info_outline,
              size: details ? 25 : 25,
              color: details ? Colors.grey : Colors.deepPurple,
            ),
          ),
        ),
      ]
    );
  }
}


Widget productCard(
String title,
String price,
String rating,
String imagePath
    ) {
  return ProductCardState(title: title, price: price, rating: rating, imagePath: imagePath);
}

/*
Widget productCard(String title, String price, String rating, String imagePath) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border(
        bottom: BorderSide(color: Colors.black),
        top: BorderSide(color: Colors.black),
        left: BorderSide(color: Colors.black),
        right: BorderSide(color: Colors.black),
      )
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 90, height: 70, fit: BoxFit.cover),

          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

          Text("\$$price", style: const TextStyle(color: Colors.green)),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 3),
              Text(rating),
            ],
          ),
        ],
      ),
    ),
  );
}*/
