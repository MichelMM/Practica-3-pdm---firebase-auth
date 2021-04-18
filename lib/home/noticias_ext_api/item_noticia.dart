import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:google_login/models/new.dart';

class ItemNoticia extends StatelessWidget {
  final New noticia;
  ItemNoticia({Key key, @required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Card(
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: ExtendedImage.network(
                  "${noticia.urlToImage}",
                  height: 110,
                  fit: BoxFit.cover,
                  cache: true,
                  loadStateChanged: (ExtendedImageState state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                        
                        return Image.asset(
                          "assets/loading.gif",
                          fit: BoxFit.fill,
                        );
                        break;

                      ///if you don't want override completed widget
                      ///please return null or state.completedWidget
                      //return null;
                      //return state.completedWidget;
                      case LoadState.completed:
                        
                        return null;
                        break;
                      case LoadState.failed:
                        return GestureDetector(
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.asset(
                                "assets/failed.jpg",
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Text(
                                  "load image failed, click to reload",
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            state.reLoadImage();
                          },
                        );
                        break;
                    }
                    return Text("???");
                  },
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${noticia.title}",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${noticia.publishedAt}",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${noticia.description ?? "Descripcion no disponible"}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${noticia.author ?? "Autor no disponible"}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
