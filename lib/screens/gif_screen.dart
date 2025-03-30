import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:search_gifs_http_flutter/widgets/search_gifs.dart';
import '../services/gif_service.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/title_animation.dart';
import 'full_screen.dart';

class GifSearchScreen extends StatefulWidget {
  const GifSearchScreen({super.key});

  @override
  State<GifSearchScreen> createState() => _GifSearchScreenState();
}

class _GifSearchScreenState extends State<GifSearchScreen> {
  final GifService _gifService = GifService();
  List<String> _gifs = [];
  bool _isLoading = false;

  void _searchGifs(String query) async {
    setState(() {
      _isLoading = true;
    });

    final gifs = await _gifService.searchGifs(query);

    setState(() {
      _gifs = gifs;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              TitleAnimation(),
              SearchForm(onSearch: _searchGifs),
              Expanded(
                child: _isLoading
                    ? LoadingWidget()
                    : _gifs.isEmpty
                        ? const Center(
                            child: Text('No GIFs found'),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: _gifs.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FullScreenGif(
                                        url: _gifs[index],
                                      ),
                                    ),
                                  );
                                },
                                child: CachedNetworkImage(
                                  // кэширует gif при повторной загрузке
                                  imageUrl: _gifs[index],
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
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
