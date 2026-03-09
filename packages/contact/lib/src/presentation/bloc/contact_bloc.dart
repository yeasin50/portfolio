import 'package:contact/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_bloc.freezed.dart';

// handles contact form
class GetInTouchCubit extends Cubit<GetInTouchState> {
  GetInTouchCubit({required this.repo})
    : super(GetInTouchState(req: ContactRequest.empty));

  final IConnectRepo repo;

  bool get isValid {
    final req = state.req;
    return req.name.trim().isNotEmpty &&
        req.email.trim().isNotEmpty &&
        req.subject.trim().isNotEmpty &&
        req.message.trim().length > 7;
  }

  void update(ContactRequest req) {
    emit(state.copyWith(req: req, error: null));
  }

  Future<void> submit() async {
    emit(state.copyWith(isLoading: true));
    final result = await repo.contact(state.req);

    if (result.success) {
      emit(state.copyWith(isAlreadySubmited: true, isLoading: false));
    } else {
      emit(state.copyWith(error: "failed to submit", isLoading: false));
    }
  }
}

@freezed
abstract class GetInTouchState with _$GetInTouchState {
  const factory GetInTouchState({
    required ContactRequest req,
    String? error,
    @Default(false) bool isLoading,
    @Default(false) bool isAlreadySubmited, // can;t use bool for testing
  }) = _GetInTouchState;
}
