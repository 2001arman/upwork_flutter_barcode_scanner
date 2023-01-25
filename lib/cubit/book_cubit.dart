import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upwork_barcode/service/api_service.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookInitial());

  void getData() async {
    try {
      emit(BookLoading());
      List<Map> bookData = await ApiService().getBookData();
      emit(BookSuccess(bookData));
    } catch (e) {
      emit(BookFailed(e.toString()));
    }
  }
}
