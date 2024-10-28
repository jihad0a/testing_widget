import 'package:flutter/material.dart';
import 'details_page.dart';

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
        child: Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            childAspectRatio: 0.8,
            shrinkWrap: true,

            children: const [
              ProductCardState(title: "Delicious Burger", price: '7.5',rating: '5.0',imagePath: 'assets/burger.png', isAvailable: true,),
              ProductCardState(title: "Pizza Hot", price:'10.00',rating: '4.5',imagePath: 'assets/pizza.png', isAvailable: true,),
              ProductCardState(title: "Fries Combo", price:'5.5',rating: '4.2',imagePath: 'assets/fries.png', isAvailable: true,),
              ProductCardState(title: "Chicken Wings", price:'6.8',rating: '4.8',imagePath: 'assets/wings.png', isAvailable: true,),
              ProductCardState(title: "Sushi Special", price:'10.5',rating: '4.9',imagePath: 'assets/sushi.png', isAvailable: true,),
              ProductCardState(title: "Pasta Delight", price:'9.0',rating: '4.7',imagePath: 'assets/pasta.png', isAvailable: true,),
            ],
          ),
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
  final bool isAvailable;

  const ProductCardState(
      {required this.title,
        required this.price,
        required this.rating,
        required this.imagePath,
        required this.isAvailable,
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
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetailsPage(
                        title: widget.title,
                        price: widget.price,
                        rating: widget.rating,
                        imagePath: widget.imagePath,
                        isAvailable: true,)));
        },

      child: Stack(
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
                  widget.imagePath, height: 90, width: 90, fit: BoxFit.contain,),
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
                  favorite ? Icons.favorite : Icons.favorite_border_sharp,
                  color: favorite ? Colors.red : Colors.black,
                  size: favorite ? 25 : 25,
                )),
          ),
        Positioned(
          right: 1,
          bottom: 29,
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
            bottom: 29,
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
                color: details ? Colors.green : Colors.deepPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


