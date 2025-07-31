import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late final PageController _pageControllerTrending;
  late final PageController _pageControllerTopRated;
  int _currentPageTrending = 0;
  int _currentPageTopRated = 0;

  @override
  void initState() {
    super.initState();
    _pageControllerTrending = PageController(viewportFraction: 0.7);
    _pageControllerTopRated = PageController(viewportFraction: 0.7);
    _pageControllerTrending.addListener(() {
      int next = _pageControllerTrending.page!.round();
      if (_currentPageTrending != next) {
        setState(() {
          _currentPageTrending = next;
        });
      }
    });
    _pageControllerTopRated.addListener(() {
      int next = _pageControllerTopRated.page!.round();
      if (_currentPageTopRated != next) {
        setState(() {
          _currentPageTopRated = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageControllerTrending.dispose();
    _pageControllerTopRated.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'CINE',
          style: GoogleFonts.aBeeZee(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trending Movies',
                style: GoogleFonts.aBeeZee(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 300, // Adjusted for largest item
                child: PageView.builder(
                  controller: _pageControllerTrending,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10, // Number of items to scroll through
                  itemBuilder: (context, index) {
                    final isCenter = _currentPageTrending == index;
                    final isAdjacent = (_currentPageTrending - 1 == index || _currentPageTrending + 1 == index) && index >= 0 && index < 10;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Transform.scale(
                        scale: isCenter ? 1.2 : (isAdjacent ? 0.9 : 0.7),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            width: isCenter ? 200.0 : (isAdjacent ? 120.0 : 80.0),
                            height: 300.0, // Uniform height for simplicity
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Top Rated Movies',
                style: GoogleFonts.aBeeZee(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 250, // Adjusted for largest item
                child: PageView.builder(
                  controller: _pageControllerTopRated,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10, // Number of items to scroll through
                  itemBuilder: (context, index) {
                    final isCenter = _currentPageTopRated == index;
                    final isAdjacent = (_currentPageTopRated - 1 == index || _currentPageTopRated + 1 == index) && index >= 0 && index < 10;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Transform.scale(
                        scale: isCenter ? 1.2 : (isAdjacent ? 0.9 : 0.7),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            width: isCenter ? 180.0 : (isAdjacent ? 100.0 : 70.0),
                            height: 250.0, // Uniform height for simplicity
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}