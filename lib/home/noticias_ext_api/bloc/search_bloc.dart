import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_login/models/new.dart';
import 'package:google_login/utils/news_repository.dart';
import 'package:hive/hive.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  static final SearchBloc _searchSingleton = SearchBloc._internal();

  factory SearchBloc() {
    return _searchSingleton;
  }

  SearchBloc._internal() : super(SearchInitial());

  Box _newsBox = Hive.box("OfflineNews");

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is RequestNewsEvent) {
      yield LoadingState();
      List<New> news;
      try {
        news = await NewsRepository().getAvailableNoticias(event.title);
      } catch (e) {
        //arroje un error
        news = null;
      }

      if (news  != null) {
        _newsBox.put("news", news);
        yield LoadedNewsState(noticiasList: news ?? []);
      } else {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          yield ErrorMessageState(errorMsg: "Error, la busqueda falló");
        } else {
          yield NoInternetState();
          yield LoadedNewsState(noticiasList: _newsBox.get("news"));
        }
      }
    }
  }
}
