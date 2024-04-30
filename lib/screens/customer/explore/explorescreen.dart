import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerheaderfooter.dart';
import 'package:project_v/screens/customer/explore/productdetails.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}


class ProductItem extends StatelessWidget {
  final String imageURL;
  final String name;
  final String price;
  final VoidCallback? onTap;
  final VoidCallback? onAddtoCart;

  const ProductItem({
    super.key,
    required this.imageURL,
    required this.name,
    required this.price,
    this.onTap,
    this.onAddtoCart,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 150, // Adjust the height as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(imageURL),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color:
                    const Color(0xFFECECF8), // Specify the color of the border
                width: 2, // Specify the width of the border
              ),
            ),
          ),
          const SizedBox(height: 8), // Adjust vertical spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: onAddtoCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      AppConstants.addtoCartIconPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return HeaderFooter(
      context: context,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20), // Adjust the top padding as needed
        child: Column(
          children: [
            Container(
              width: 380,
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: SizedBox(
                              height: double.infinity,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search Products',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF9D9D9D),
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0.80,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const SizedBox(
                            width: 95,
                            child: Text(
                              'All categories',
                              style: TextStyle(
                                color: Color(0xFF262626),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            ),
                          ),
                          Container(
                            width: 24,
                            height: 24,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 6.0, left: 6.0),
                                  child: Image.asset(
                                    AppConstants
                                        .dropdownIconPath, // Dropdown icon
                                    width: 15,
                                    height: 15,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 12,
                            height: 24,
                            child: VerticalDivider(
                              color: Colors.black.withOpacity(0.2),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0, left: 4.0),
                          child: Image.asset(
                            AppConstants.searchIconPath, // Search icon
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Adjust vertical spacing here
            Expanded(
              child: GridView.builder(
                padding:
                    const EdgeInsets.all(18), // Adds padding around the grid
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.75,
                ),
                itemCount: 6, // Adjust the number of products
                itemBuilder: (context, index) {
                  return Center(
                    // Center the ProductItem widget
                    child: ProductItem(
                      imageURL:
                          'assets/images/product_${index + 1}.jpg', // Replace with actual image URL
                      name: 'Product ${index + 1}',
                      price: '₱${(index + 1) * 100}', // Adjust the price
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              imageURL:
                                  'assets/images/product_${index + 1}.jpg',
                              name: 'Product ${index + 1}',
                              price: '₱${(index + 1) * 100}',
                            ),
                          ),
                        );
                      },
                      onAddtoCart: () {
                        // Show a pop-up message indicating that the item was added to the cart
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Success'),
                              content: const Text(
                                  'Product added to cart successfully!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      title: "ExploreScreen",
      buttonStatus: const [false, true, false, false, false],
    );
  }
}