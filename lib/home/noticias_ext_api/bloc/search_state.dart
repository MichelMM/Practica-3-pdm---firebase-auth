part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class LoadingState extends SearchState {}

class NoInternetState extends SearchState {}

class LoadedNewsState extends SearchState {
  final List<dynamic> noticiasList;

  LoadedNewsState({@required this.noticiasList});
  @override
  List<Object> get props => [noticiasList];
}

class ErrorMessageState extends SearchState {
  final String errorMsg;

  ErrorMessageState({@required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}