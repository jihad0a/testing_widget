import 'food_page.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String title;
  final String price;
  final String rating;
  final String imagePath;
  final bool isAvailable;

  const DetailsPage({
    super.key,
    required this.title,
    required this.price,
    required this.rating,
    required this.imagePath,
    this.isAvailable = true,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  bool cart = false;

  snack( String msg, context ) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(content: Text(msg,style: const TextStyle(
       color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold
     ),),

     shape: const StadiumBorder(
       side: BorderSide(
           color: Colors.white,
       )
     ),
     duration: const Duration(
       seconds: 2,
     ),
     )
   );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

        title: Text(widget.title),
        backgroundColor: Colors.white60,
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black12,
                ),
                child: Image.asset(
                  widget.imagePath, height: 290, width: 290, fit: BoxFit.cover,),
              ),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 1.2,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Name: ${widget.title}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5,),
                    Text('Rating: ${widget.rating}⭐',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5,),
                    Text('Price: \$${widget.price}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      widget.isAvailable ? "Available" : "Out of Stock",style:
                      TextStyle(
                        color: widget.isAvailable ? Colors.green : Colors.red,
                        fontSize:  widget.isAvailable ? 16 : 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: widget.isAvailable && !cart ? _addToCart : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: cart ? Colors.grey : Colors.green[900]),
                          child: Text( cart ? 'In Cart' : 'Added to Cart',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        ElevatedButton(
                          onPressed: widget.isAvailable ? _buyNow : null,
                          child: const Text('Buy Now',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void _addToCart() {
    setState(() {
      cart = true;
    });
    Snack('${widget.title} is Added to Cart', context);
  }

  void _buyNow() {
    Snack('${widget.title} Purchased!', context);
  }
}












