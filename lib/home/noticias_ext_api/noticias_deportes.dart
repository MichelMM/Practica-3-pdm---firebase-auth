import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/search_bloc.dart';
import 'item_noticia.dart';

class NoticiasDeportes extends StatefulWidget {
  const NoticiasDeportes({Key key}) : super(key: key);

  @override
  _NoticiasDeportesState createState() => _NoticiasDeportesState();
}

class _NoticiasDeportesState extends State<NoticiasDeportes> {
  List<ItemNoticia> news;

  @override
  void initState() {
    super.initState();
    news = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) =>
            SearchBloc()..add(RequestNewsEvent(title: "sports")),
        child: BlocConsumer<SearchBloc, SearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ErrorMessageState) {
              return Center(
                child: Text("Algo salio mal", style: TextStyle(fontSize: 32)),
              );
            }
            if (state is LoadedNewsState) {
              return Column(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      labelText: "Ingrese Título",
                      suffixIcon: Icon(
                        Icons.search,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onSubmitted: (content) {
                      setState(() {
                        SearchBloc().add(RequestNewsEvent(title: content));
                      });
                    },
                  )),
                  Expanded(
                    flex: 8,
                    child: ListView.builder(
                      itemCount: state.noticiasList.length,
                      itemBuilder: (context, index) {
                        return ItemNoticia(
                          noticia: state.noticiasList[index],
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
