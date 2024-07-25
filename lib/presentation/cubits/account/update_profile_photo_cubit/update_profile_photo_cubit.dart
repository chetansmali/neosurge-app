import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/user.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/account/update_profile_photo_params.dart';
import '../../../../domain/usecases/account/update_profile_photo.dart';

part 'update_profile_photo_state.dart';

@injectable
class UpdateProfilePhotoCubit extends Cubit<UpdateProfilePhotoState> {
  final UpdateProfilePhoto _updateProfilePhoto;

  UpdateProfilePhotoCubit(this._updateProfilePhoto) : super(UpdateProfilePhotoInitial());

  void updateProfilePhoto({File? file}) async {
    emit(UpdateProfilePhotoLoading());
    final res = await _updateProfilePhoto(UpdateProfilePhotoParams(file));
    emit(res.fold((l) => UpdateProfilePhotoFailure(l.errorType, l.error), (r) => UpdateProfilePhotoSuccess(r)));
  }
}
