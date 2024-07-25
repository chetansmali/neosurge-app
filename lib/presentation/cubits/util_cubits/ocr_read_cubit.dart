import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/kyc/ocr_read_response_model.dart';
import '../../../domain/entities/app_error.dart';

part 'ocr_read_state.dart';

@injectable
class OcrReadCubit extends Cubit<OcrReadState> {
  OcrReadCubit() : super(OcrReadInitial());

// void ocrRead({required File file, required DocumentType docType}) async {
//   emit(OcrReadLoading());
//   // final response = await _ocrRead(
//   //   OcrReadParams(documentType: docType, file: file),
//   // );
//   final response = await _extractText(panImg: file);

//   emit(
//     response.fold(
//       (l) => OcrReadFailure(appErrorType: l.errorType, errorMessage: l.error),
//       (r) => OcrReadLoaded(ocrResponse: r),
//     ),
//   );
// }

// Future<Either<AppError, OcrReadResponseModel>> _extractText({
//   required File panImg,
// }) async {
//   final inputImage = InputImage.fromFile(panImg);
//   final textRecognizer = TextRecognizer();
//   final recognisedText = await textRecognizer.processImage(inputImage);

//   var panData = recognisedText.text;

//   var panNumber = RegExp(
//         r'[A-Z]{5}[0-9]{4}[A-Z]{1}',
//       ).stringMatch(panData) ??
//       '';

//   var fullNames = RegExp(
//     r'[A-Z]+ [A-Z]+ [A-Z]+',
//   ).allMatches(panData);

//   var dob = RegExp(
//         r'[0-9]{2}/[0-9]{2}/[0-9]{4}',
//       ).stringMatch(panData) ??
//       '';

//   if (panNumber.isNotEmpty) {
//     return Right(
//       OcrReadResponseModel(
//         docNum: panNumber,
//         dob: dob,
//         docType: 'PAN',
//         status: true,
//         fullName: fullNames.elementAt(1).group(0) ?? '',
//       ),
//     );
//   } else {
//     return const Left(
//       AppError(
//         AppErrorType.api,
//         error:
//             'We are unable to read your PAN card. Please enter it manually.',
//       ),
//     );
//   }
// }
}
