part of 'book_cubit.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookSuccess extends BookState {
  final List<Map> bookData;

  const BookSuccess(this.bookData);

  @override
  List<Object> get props => [bookData];
}

class BookFailed extends BookState {
  final String error;

  const BookFailed(this.error);

  @override
  List<Object> get props => [error];
}
