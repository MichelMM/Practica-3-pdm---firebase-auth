part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class RequestNewsEvent extends SearchEvent {
  final String title;

  RequestNewsEvent({@required this.title});
  @override
  List<Object> get props => [title];
}