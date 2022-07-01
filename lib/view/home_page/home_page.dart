import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_islemleri/view/info_page/info_page.dart';
import 'package:firebase_islemleri/core/services/api_service.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/models/movie_model.dart';
import '../../core/widgets/search_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Movie>> _nowPlayingMovieList;
  late Future<List<Movie>> _recentlyMovieList;
  @override
  void initState() {
    super.initState();
    _nowPlayingMovieList = ApiService().getNowPlayingMovie();
    _recentlyMovieList = ApiService().getRecentlyReleased();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        backgroundColor: AppConstants.mainColor,
        title: Text(
          "Movie Time".toUpperCase(),
          style: AppConstants.mainTitleStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchMovie());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Container(
        color: AppConstants.mainColor,
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        "Now Playing".toUpperCase(),
                        style: AppConstants.pageTitleStyle,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                FutureBuilder<List>(
                    future: _nowPlayingMovieList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var movieList = snapshot.data!;
                        return CarouselSlider.builder(
                          itemCount: movieList.length,
                          options: CarouselOptions(
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            pauseAutoPlayOnTouch: true,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                          ),
                          itemBuilder: (ctx, index, realIdx) {
                            Movie movie = movieList[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        InfoPage(movie: movie),
                                  ),
                                );
                              },
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: <Widget>[
                                  ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/img_not_found.jpg'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 15,
                                      left: 15,
                                    ),
                                    child: Text(
                                      movie.title.toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Text(
                        "Upcoming".toUpperCase(),
                        style: AppConstants.pageTitleStyle,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FutureBuilder<List<Movie>>(
                      future: _recentlyMovieList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var movieList = snapshot.data!;

                          return GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      mainAxisExtent: 225,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemCount: movieList.length,
                              itemBuilder: (BuildContext ctx, index) {
                                var movie = movieList[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            InfoPage(movie: movie),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: <Widget>[
                                      ClipRRect(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/img_not_found.jpg'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 15,
                                          left: 15,
                                        ),
                                        child: Text(
                                          movie.title.toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RapportList extends StatefulWidget {
  final ScrollController parentScrollController;
  RapportList({required this.parentScrollController});
  @override
  _RapportListState createState() => _RapportListState();
}

class _RapportListState extends State<RapportList> {
  ScrollPhysics physics = ScrollPhysics();
  // NeverScrollableScrollPhysics()
  late ScrollController _listViewScrollController;

  void listViewScrollListener() {
    print("smth");
    if (_listViewScrollController.offset >=
            _listViewScrollController.position.maxScrollExtent &&
        !_listViewScrollController.position.outOfRange) {
      if (widget.parentScrollController.offset == 0) {
        widget.parentScrollController.animateTo(50,
            duration: Duration(milliseconds: 200), curve: Curves.linear);
      }
      setState(() {
        physics = NeverScrollableScrollPhysics();
      });
      print("bottom");
    }
  }

  void mainScrollListener() {
    if (widget.parentScrollController.offset <=
            widget.parentScrollController.position.minScrollExtent &&
        !widget.parentScrollController.position.outOfRange) {
      setState(() {
        if (physics is NeverScrollableScrollPhysics) {
          physics = ScrollPhysics();
          _listViewScrollController.animateTo(
              _listViewScrollController.position.maxScrollExtent - 50,
              duration: Duration(milliseconds: 200),
              curve: Curves.linear);
        }
      });
      print("top");
    }
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  void initState() {
    _listViewScrollController = ScrollController();
    _listViewScrollController.addListener(listViewScrollListener);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.parentScrollController.addListener(mainScrollListener);
    return ListView.builder(
      controller: _listViewScrollController,
      physics: physics,
      shrinkWrap: true,
      itemCount: 50,
      itemBuilder: (context, index) {
        return ListTile(
          title: GestureDetector(
            child: Row(
              children: <Widget>[
                Container(child: Text("text $index")),
              ],
            ),
          ),
        );
      },
    );
  }
}
