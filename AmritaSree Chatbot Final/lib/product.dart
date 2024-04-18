import 'package:amritasree_chatbot/productdetails.dart';
import 'package:flutter/material.dart';

// Defining a new class called Products that inherits from the StatefulWidget class
class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _HomeState();
}

// Define the attributes inside the state of the Products widget
class _HomeState extends State<Products> {
  late final PageController pageController;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> gridMap = []; // List to store product data
  List<Map<String, dynamic>> filteredGridMap = []; // List to store filtered product data

  @override
  void initState() {
    super.initState();

    // Initialize the gridMap with product data
    gridMap = [
      {
        "title": "FISH PICKLE",
        "info": "FISH PICKLE - 1 JAR",
        "rating": 4,
        "clusterInfo": " Vallikavu",
        "images":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUVl5IHPa9_tYxvEFfWSf2QFIL_ThS6WgZr2fdXR22q1OYdn-oLoYZOKi6or9tt5qGvmc&usqp=CAU",
      },
      {
        "title": "JUTE BAG",
        "info": "JUTE BAG - PACK OF 2",
        "rating": 2,
        "clusterInfo": " Alleppey",
        "images":
            "https://m.media-amazon.com/images/I/81F95F4-DNL._SL1500_.jpg",
      },
      {
        "title": "MANGO PICKLE",
        "info": "MANGO PICKLE - 1 JAR",
        "rating": 4,
        "clusterInfo": " Kozhikode",
        "images":
            "https://weaveskart.com/wp-content/uploads/2023/05/Homemade-Cut-Mango-Pickle-1.jpg",
      },
      {
        "title": "FRESH COW MILK",
        "info": "COW MILK - 1LTR PACK",
        "rating": 5,
        "clusterInfo": " Vallikavu",
        "images":
            "https://fromscratchfarmstead.com/wp-content/uploads/2022/03/fresh-cow-milk.jpg",
      },
      {
        "title": "CHILLI PAPADS",
        "info": "CHILLI PAPADS- 1 PACK",
        "rating": 3,
        "clusterInfo": " Alleppey",
        "images":
            "https://m.media-amazon.com/images/I/51G1YAPh2eL._SX300_SY300_QL70_FMwebp_.jpg",
      },
      {
        "title": "JUTE BAG",
        "info": "JUTE BAG - PACK OF 2",
        "rating": 1,
        "clusterInfo": " Kottayam",
        "images":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUM1gYzKhohTkZUe5LnvdQc-L7LHewzYCopA&usqp=CAU",
      },
      {
        "title": "COTTON BAG",
        "info": "COTTON BAG - 1 BAG",
        "rating": 2,
        "clusterInfo": " Vallikavu",
        "images":
            "https://m.media-amazon.com/images/I/61t0yIO1QYL._SL1500_.jpg",
      },
      {
        "title": "HERBAL BODY SOAP",
        "info": "BODY SOAP - PACK OF 3",
        "rating": 3,
        "clusterInfo": " Kasaragod",
        "images":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBvSicdE4sLt2CoDuipY9YyGbXIhBwLjPynk5gNFVDXoF_wNF9fGFWFO46TCOlXEgAuJQ&usqp=CAU",
      },
      {
        "title": "HERBAL TEA",
        "info": "MINT HERBAL TEA - 25 TEA BAGS",
        "rating": 5,
        "clusterInfo": " Alleppey",
        "images":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC4uAfnWG9a7uQ13t5iQ8ixgGkc5sDL9J4Pw&usqp=CAU",
      },
      {
        "title": "MANGO JAM",
        "info": "MANGO JAM - 1 BOTTLE",
        "rating": 2,
        "clusterInfo": " Thrissur",
        "images":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGFGr-LC1w3f75Y7S21g9toVL6LjX1wY7Iyg&usqp=CAU",
      },
      {
        "title": "NATURAL BODY SOAP",
        "info": "ROSE EXTRACT SOAPS - PACK OF 5",
        "rating": 3,
        "clusterInfo": " Kottayam",
        "images":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBzPqT6ECihUEXuKWSEZTxTJ3W1lx5s0Cduw&usqp=CAU",
      },
    ];
    filteredGridMap = gridMap; // Initialize with all products
  }

// Filter products based on the search query
  void _filterProducts(String query) {
    setState(() {
      filteredGridMap = gridMap
          .where((product) =>
              product['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

// Build the UI for the Products widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 237, 250),
      //Constructing the AppBar
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3EDF7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: const Color(0xFF0B0000),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'PRODUCTS',
          style: TextStyle(
            fontFamily: 'Monsterrat',
            fontWeight: FontWeight.w400,
            fontSize: 21,
            color: Color(0xFF0B0000),
            letterSpacing: 2,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 10),
            child: ElevatedButton(
              onPressed: () {
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFFF3EDF7)),
                minimumSize: MaterialStateProperty.all(const Size(47, 47)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      width: 0,
                      color: Color(0xFFF3EDF7),
                    ),
                  ),
                ),
              ),
              child: const Icon(
                Icons.translate,
                color: Color.fromARGB(255, 4, 4, 4),
                size: 35,
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),

      // Set the body with a SingleChildScrollView and a Column
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(
                height: 36.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 20.0),
                child: Row(
                  children: [
                    // Container 1: Search bar
                    Expanded(
                      child: Container(
                        height: 44.0,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromRGBO(145, 28, 213, 1)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 122, 76, 175)
                                  .withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 0),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: [
                            // Search input field
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (query) => _filterProducts(query),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search',
                                ),
                              ),
                            ),
                            // Search icon
                            Image.asset(
                              'assets/icons/search.png',
                              height: 25,
                            )
                          ],
                        ),
                      ),
                    ),
                    // Container 2: Filter icon
                    const SizedBox(width: 10),
                    // Add a container with a filter icon
                    Container(
                      height: 50.0,
                      width: 50.0,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 146, 44, 205)
                                .withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Image.asset(
                        'assets/icons/adjust.png',
                        color: const Color.fromARGB(255, 0, 0, 0),
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ),
              // Add a Padding widget with a GridB widget containing the filteredGridMap
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: GridB(filteredGridMap),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Define a StatefulWidget called GridB
class GridB extends StatefulWidget {
  final List<Map<String, dynamic>> gridMap;

  const GridB(this.gridMap, {super.key});

  @override
  State<GridB> createState() => _GridBState();
}

// Define the state for the GridB widget
class _GridBState extends State<GridB> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // Disable scrolling for the GridView
      physics: const NeverScrollableScrollPhysics(),
      // Enable shrink wrapping for the GridView
      shrinkWrap: true,
      // Set the grid delegate for the GridView
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 310,
      ),
      itemCount: widget.gridMap.length,
      itemBuilder: (_, index) {
        final product = widget.gridMap[index];
        final rating =
            product['rating'] ?? 3;

        // Create a GestureDetector for each item to handle user interactions
        return GestureDetector(
          onTap: () {
            // Navigate to ProductDetailPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: const Color.fromARGB(255, 255, 255, 255),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  // Display the image using Image.network
                  child: Image.network(
                    "${widget.gridMap.elementAt(index)['images']}",
                    height: 170,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the product title
                      Text(
                        "${widget.gridMap.elementAt(index)['title']}",
                        style: Theme.of(context).textTheme.titleMedium!.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2.0,
                              ),
                            ),
                      ),
                      const SizedBox(height: 10.0),
                      // Display the product rating as stars
                      Row(
                        children: List.generate(
                          5,
                          (starIndex) => Icon(
                            starIndex < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      // Display the product cluster information
                      RichText(
                        text: TextSpan(
                          text: 'CLUSTER:',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'Ubuntu',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${product['clusterInfo']}',
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
