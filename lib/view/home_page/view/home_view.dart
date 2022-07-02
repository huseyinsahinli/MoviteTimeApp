import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_islemleri/core/constants/app_icons.dart';
import 'package:firebase_islemleri/core/constants/app_string.dart';
import 'package:firebase_islemleri/core/extensions/double_extensions.dart';
import 'package:firebase_islemleri/core/images/app_images.dart';
import 'package:firebase_islemleri/core/padding/app_padding.dart';
import 'package:firebase_islemleri/view/info_page/info_page.dart';
import 'package:firebase_islemleri/core/services/api_service.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/models/movie_model.dart';
import '../../../core/widgets/search_widget.dart';

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
        title: Text(
          AppStrings.movieTime.toUpperCase(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchMovie());
            },
            icon: AppIcon.searchIcon,
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              16.0.sizedBoxOnlyHeight,
              Padding(
                padding: AppPadding.pageTitlePadding,
                child: Row(
                  children: [
                    Text(
                      AppStrings.nowPlaying.toUpperCase(),
                      style: AppConstants.pageTitleStyle,
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
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
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
                                  builder: (context) => InfoPage(movie: movie),
                                ),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: <Widget>[
                                ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl: ImagePath.getImageUrl(
                                      movie.backdropPath,
                                    ),
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            ImagePath.imgNotFoundPath,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                Padding(
                                  padding: AppPadding.movieTitlePadding,
                                  child: Text(
                                    movie.title.toUpperCase(),
                                    style: AppConstants.movieTitleTextStyle,
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
                padding: AppPadding.pageTitlePadding,
                child: Row(
                  children: [
                    Text(
                      AppStrings.upComing.toUpperCase(),
                      style: AppConstants.pageTitleStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: 16.0.edgeIntesetsHorizontal,
                child: FutureBuilder<List<Movie>>(
                    future: _recentlyMovieList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var movieList = snapshot.data!;
                        return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
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
                                        imageUrl: ImagePath.getImageUrl(
                                          movie.backdropPath,
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                ImagePath.imgNotFoundPath,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    Padding(
                                      padding: AppPadding.movieTitlePadding,
                                      child: Text(
                                        movie.title.toUpperCase(),
                                        style: AppConstants.movieTitleTextStyle,
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
    );
  }
}
