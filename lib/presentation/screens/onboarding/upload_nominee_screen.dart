import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../common/custom_styles.dart';
import '../../../common/formatters.dart';
import '../../../common/utils.dart';
import '../../../common/validators.dart';
import '../../../constants/dropdown_constants.dart';
import '../../../constants/kyc_steps_constants.dart';
import '../../../constants/meta_strings.dart';
import '../../../data/models/kyc/get_kyc_nominee_details_model.dart';
import '../../../domain/entities/nominee_entity.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../cubits/onboarding/upload_nominee_details/upload_nominee_details_cubit.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/label_text.dart';
import 'string_list_screen.dart';

class UploadNomineeScreen extends StatefulWidget {
  const UploadNomineeScreen({super.key});

  @override
  State<UploadNomineeScreen> createState() => _UploadNomineeScreenState();
}

class _UploadNomineeScreenState extends State<UploadNomineeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static List<_CustomNomineeModel?> nominees = [null];

  @override
  void initState() {
    super.initState();
    nominees.clear();
    fetchExistingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UploadNomineeDetailsCubit, UploadNomineeDetailsState>(
        listener: (context, state) {
          if (state is UploadNomineeDetailsSuccess && !state.isFetch) {
            context.read<OnboardingPageCubit>().goToNextPage();
            return;
          }
          if (state is UploadNomineeDetailsSuccess &&
              state.isFetch &&
              !state.isDelete) {
            List<GetKycNomineeDetailsModel> nomList = state.nomineeList!;

            for (int i = 0; i < nomList.length; i++) {
              nominees.add(_CustomNomineeModel(
                id: nomList[i].id,
                nomineeFullName: nomList[i].nomineeFullName,
                nomineeDateOfBirth: nomList[i].nomineeDateOfBirth,
                nomineeRelationTypeId: nomList[i].nomineeRelationType.value,
                allocationPercentage: nomList[i].allocationPercentage,
                guardianName: nomList[i].guardianName,
                guardianRelationshipId: nomList[i].guardianRelationship?.value,
              ));
            }
          }

          if (state is UploadNomineeDetailsSuccess && state.isDelete) {
            int index = state.deleteIndex ?? nominees.length - 1;

            nominees.removeAt(index);

            var temp = (100 / nominees.length).floor().toInt();
            var length = nominees.length - 1;
            for (int i = 0; i <= length; i++) {
              if (i == length) {
                nominees[i]!.copyWith(
                    allocationPercentage: (100 - length * temp).toDouble());
              } else {
                nominees[i]!.copyWith(allocationPercentage: temp.toDouble());
              }
            }

            Fluttertoast.showToast(msg: 'Nominee deleted successfully');
          }

          if (state is UploadNomineeDetailsFailure && !state.isFetch) {
            Utils.showErrorAlert(
              context,
              Utils.getErrorMessage(
                  errorType: state.appErrorType, msg: state.errorMessage),
            );
            return;
          }
        },
        builder: (context, state) {
          if (state is UploadNomineeDetailsLoading && state.isFetch) {
            return const Center(child: CustomLoader());
          }
          if (state is UploadNomineeDetailsFailure && state.isFetch) {
            return Center(
                child: Text(Utils.getErrorMessage(
                    errorType: state.appErrorType, msg: state.errorMessage)));
          }
          if (nominees.isEmpty) {
            nominees.add(_CustomNomineeModel(
              nomineeFullName: '',
              nomineeDateOfBirth: DateTime(DateTime.now().year - 18),
              nomineeRelationTypeId: null,
              allocationPercentage: 100,
            ));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nominees",
                        style: baseTextStyle18500,
                        textAlign: TextAlign.center,
                      ),
                      const Gap(5),
                      const Text(
                        'Secure your future by adding nominees to your mutual fund investments.',
                      ),
                      for (int i = 0; i < nominees.length; i++)
                        _NomineeFields(
                          index: i,
                          onDateChanged: () => setState(() => nominees),
                        ),
                      if (nominees.length != 3)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () => setState(
                              () {
                                nominees.add(_CustomNomineeModel(
                                  nomineeFullName: '',
                                  nomineeDateOfBirth:
                                      DateTime(DateTime.now().year - 18),
                                  nomineeRelationTypeId: 0,
                                  allocationPercentage: 100,
                                ));
                                var temp =
                                    (100 / nominees.length).floor().toInt();
                                var length = nominees.length - 1;
                                for (int i = 0; i <= length; i++) {
                                  if (i == length) {
                                    nominees[i] = _CustomNomineeModel(
                                      id: nominees[i]?.id,
                                      nomineeFullName:
                                          nominees[i]?.nomineeFullName ?? '',
                                      nomineeDateOfBirth: nominees[i]
                                              ?.nomineeDateOfBirth ??
                                          DateTime(DateTime.now().year - 18),
                                      nomineeRelationTypeId:
                                          nominees[i]?.nomineeRelationTypeId,
                                      guardianName: nominees[i]?.guardianName,
                                      guardianRelationshipId:
                                          nominees[i]?.guardianRelationshipId,
                                      allocationPercentage:
                                          (100 - length * temp).toDouble(),
                                    );
                                  } else {
                                    nominees[i] = _CustomNomineeModel(
                                      id: nominees[i]?.id,
                                      nomineeFullName:
                                          nominees[i]?.nomineeFullName ?? '',
                                      nomineeDateOfBirth: nominees[i]
                                              ?.nomineeDateOfBirth ??
                                          DateTime(DateTime.now().year - 18),
                                      nomineeRelationTypeId:
                                          nominees[i]?.nomineeRelationTypeId,
                                      guardianName: nominees[i]?.guardianName,
                                      guardianRelationshipId:
                                          nominees[i]?.guardianRelationshipId,
                                      allocationPercentage: temp.toDouble(),
                                    );
                                  }
                                }
                              },
                            ),
                            child: Text(
                              'Add Another Nominee',
                              style: baseTextStyle.copyWith(
                                  color: const Color(0xFF326CF9), fontSize: 14),
                            ),
                          ),
                        ),
                      const Gap(50),
                    ]),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar:
          BlocBuilder<UploadNomineeDetailsCubit, UploadNomineeDetailsState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: nominees.isNotEmpty
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          double totalPercentage = 0;
                          for (var nominee in nominees) {
                            totalPercentage += nominee!.allocationPercentage;
                          }
                          if (totalPercentage != 100.0) {
                            Utils.showWarningAlert(context,
                                'Your total nomination percentage allocation must be equal to 100%');
                          } else {
                            List<NomineeEntity> allNominees = [];
                            for (var nominee in nominees) {
                              allNominees.add(NomineeEntity(
                                id: nominee!.id,
                                nomineeFullName: nominee.nomineeFullName.trim(),
                                nomineeDateOfBirth: nominee.nomineeDateOfBirth,
                                nomineeRelationTypeId:
                                    nominee.nomineeRelationTypeId,
                                allocationPercentage:
                                    nominee.allocationPercentage,
                              ));
                            }

                            context
                                .read<UploadNomineeDetailsCubit>()
                                .uploadNomineeDetails(nomineeList: allNominees);
                          }
                        }
                      }
                    : null,
                child: state is UploadNomineeDetailsLoading
                    ? Assets.animations.loading.lottie()
                    : const Text('Continue'),
              ),
            ),
          );
        },
      ),
    );
  }

  void fetchExistingData() {
    if (_isNotFirstTime) {
      context.read<UploadNomineeDetailsCubit>().fetchNomineeDetails();
    }
  }

  bool get _isNotFirstTime {
    final int maxCompletedStep =
        context.read<OnboardingPageCubit>().state.maxCompletedStep;
    final bool isKycCompliant =
        context.read<OnboardingPageCubit>().state.isKycCompliant;

    setState(() {});

    return maxCompletedStep >= KycCompliantStepsRoutes.nomineeDetails.value &&
            isKycCompliant ||
        maxCompletedStep >= NonKycFlowRoutes.nomineeDetails.value &&
            !isKycCompliant;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _NomineeFields extends StatefulWidget {
  const _NomineeFields({
    Key? key,
    required this.index,
    required this.onDateChanged,
  }) : super(key: key);
  final int index;
  final VoidCallback onDateChanged;

  @override
  State<_NomineeFields> createState() => __NomineeFieldsState();
}

class __NomineeFieldsState extends State<_NomineeFields> {
  late final TextEditingController _nameController;
  late final TextEditingController _dobController;
  late final TextEditingController _percentageController;
  late final TextEditingController _nomineeRelationController;

  String? errorMsg = '';
  int? selectedIndex;
  DateTime date = DateTime(DateTime.now().year - 18);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text:
            _UploadNomineeScreenState.nominees[widget.index]?.nomineeFullName ??
                '');
    _dobController = TextEditingController(
        text: DateFormat('dd-MM-yyyy')
            .format(_UploadNomineeScreenState
                    .nominees[widget.index]?.nomineeDateOfBirth ??
                DateTime(DateTime.now().year - 18))
            .toString());
    _percentageController = TextEditingController();
    _nomineeRelationController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _percentageController.text = (_UploadNomineeScreenState
                    .nominees[widget.index]?.allocationPercentage ??
                0.0)
            .toStringAsFixed(0);
        if (_UploadNomineeScreenState
                .nominees[widget.index]?.nomineeRelationTypeId !=
            null) {
          _nomineeRelationController.text = DropDownConstants
              .nomineeRelationshipList[_UploadNomineeScreenState
                      .nominees[widget.index]!.nomineeRelationTypeId! -
                  1]
              .name
              .toString();
        }
      });
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF5B89FA),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 7, bottom: 7),
                child: Text(
                  'Nominee ${widget.index + 1}',
                  style: baseTextStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
            if (widget.index != 0)
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => _RemoveNomineeDialog(
                            onPressed: () {
                              _UploadNomineeScreenState.nominees
                                  .removeAt(widget.index);

                              var temp = (100 /
                                      _UploadNomineeScreenState.nominees.length)
                                  .floor()
                                  .toInt();
                              var length =
                                  _UploadNomineeScreenState.nominees.length - 1;
                              for (int i = 0; i <= length; i++) {
                                if (i == 0) {
                                  _UploadNomineeScreenState.nominees[i] =
                                      _CustomNomineeModel(
                                    id: _UploadNomineeScreenState
                                        .nominees[i]?.id,
                                    nomineeFullName: _UploadNomineeScreenState
                                            .nominees[i]?.nomineeFullName ??
                                        '',
                                    nomineeDateOfBirth:
                                        _UploadNomineeScreenState.nominees[i]
                                                ?.nomineeDateOfBirth ??
                                            DateTime(DateTime.now().year - 18),
                                    nomineeRelationTypeId:
                                        _UploadNomineeScreenState
                                            .nominees[i]?.nomineeRelationTypeId,
                                    guardianName: _UploadNomineeScreenState
                                        .nominees[i]?.guardianName,
                                    guardianRelationshipId:
                                        _UploadNomineeScreenState.nominees[i]
                                            ?.guardianRelationshipId,
                                    allocationPercentage:
                                        (100 - length * temp).toDouble(),
                                  );
                                } else {
                                  _UploadNomineeScreenState.nominees[i] =
                                      _CustomNomineeModel(
                                    id: _UploadNomineeScreenState
                                        .nominees[i]?.id,
                                    nomineeFullName: _UploadNomineeScreenState
                                            .nominees[i]?.nomineeFullName ??
                                        '',
                                    nomineeDateOfBirth:
                                        _UploadNomineeScreenState.nominees[i]
                                                ?.nomineeDateOfBirth ??
                                            DateTime(DateTime.now().year - 18),
                                    nomineeRelationTypeId:
                                        _UploadNomineeScreenState
                                            .nominees[i]?.nomineeRelationTypeId,
                                    guardianName: _UploadNomineeScreenState
                                        .nominees[i]?.guardianName,
                                    guardianRelationshipId:
                                        _UploadNomineeScreenState.nominees[i]
                                            ?.guardianRelationshipId,
                                    allocationPercentage: temp.toDouble(),
                                  );
                                }
                              }
                              widget.onDateChanged();
                              Navigator.of(ctx).pop();
                            },
                          ));
                  setState(() {});
                },
                child: Image.asset(
                  Assets.icons.deleteNewIcon.path,
                  height: 24,
                  width: 24,
                ),
              ),
          ],
        ),
        const Gap(12.0),
        const LabelText(label: 'Full Name'),
        TextFormField(
          controller: _nameController,
          textCapitalization: TextCapitalization.words,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            _UploadNomineeScreenState.nominees[widget.index]!.nomineeFullName =
                value;
          },
          validator: (value) => Validators.validateEmptyField(
              ValidatorStrings.emptyNomineeFullNameField, value),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s\.]*$')),
          ],
          textInputAction: TextInputAction.next,
        ),
        const Gap(25),
        const LabelText(label: 'Date of Birth'),
        TextFormField(
          controller: _dobController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.datetime,
          validator: (value) {
            String? err = Validators.dobValidator(value!, shouldBeAdult: true);
            errorMsg = err;
            return null;
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'\d'),
            ),
            LengthLimitingTextInputFormatter(10),
            DateTextFormatter(),
          ],
          onChanged: (value) {
            if (value.length == 10 && Validators.dobValidator(value) == null) {
              _UploadNomineeScreenState.nominees[widget.index]!
                  .nomineeDateOfBirth = DateFormat('dd-MM-yyyy').parse(value);
              var dob = DateFormat('dd-MM-yyyy').parse(value);
              date = dob;
              widget.onDateChanged();
              setState(() {});
            }
          },
          decoration: InputDecoration(
            fillColor: errorMsg == '' || errorMsg == null
                ? AppColors.lightGrey
                : AppColors.errorRed.withOpacity(0.08),
            errorStyle: const TextStyle(
              fontSize: 0,
            ),
            suffixIcon: IconButton(
              icon: Image.asset(
                'assets/icons/calender.png',
                height: 24,
                width: 24,
              ),
              onPressed: () async {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return SizedBox(
                        height:
                            MediaQuery.of(context).copyWith().size.height / 3,
                        child: Center(
                          child: CupertinoDatePicker(
                            initialDateTime: date,
                            maximumDate: DateTime(DateTime.now().year - 18,
                                DateTime.now().month, DateTime.now().day),
                            mode: CupertinoDatePickerMode.date,
                            use24hFormat: true,
                            showDayOfWeek: true,
                            onDateTimeChanged: (DateTime newDate) {
                              _dobController.text =
                                  DateFormat('dd-MM-yyyy').format(newDate);
                              _UploadNomineeScreenState.nominees[widget.index]!
                                  .nomineeDateOfBirth = newDate;
                              date = newDate;
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ),
        const Gap(25),
        const LabelText(label: 'Relationship'),
        GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute<int>(
                builder: (context) => const StringListScreen(
                  title: 'Relationship',
                  items: DropDownConstants.nomineeRelationshipList,
                ),
              ),
            );

            if (result != null) {
              setState(() {
                selectedIndex = result;
                _nomineeRelationController.text = DropDownConstants
                    .nomineeRelationshipList[selectedIndex! - 1].name;
                _UploadNomineeScreenState
                    .nominees[widget.index]!.nomineeRelationTypeId = result;
              });
            }
          },
          child: Container(
            height: 52,
            decoration: BoxDecoration(
                color: const Color(0xFFEBEBEB),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 12, bottom: 12, top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_nomineeRelationController.text),
                  const Icon(
                    Icons.arrow_right,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(25),
        const LabelText(label: 'Percentage'),
        TextFormField(
          controller: _percentageController,
          onChanged: (value) {
            _UploadNomineeScreenState.nominees[widget.index]!
                .allocationPercentage = double.parse(value);
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: Validators.validateNomineePercentage,
          maxLength: 3,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'\d'),
            ),
            LengthLimitingTextInputFormatter(3),
          ],
          decoration: const InputDecoration(counterText: ''),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _percentageController.dispose();
    _nomineeRelationController.dispose();
    _dobController.dispose();
    super.dispose();
  }
}

class _RemoveNomineeDialog extends StatelessWidget {
  const _RemoveNomineeDialog({required this.onPressed});
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10.0, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Are you sure you want to remove',
                          style: baseTextStyle.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'this nominee?',
                            style: baseTextStyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                TextButton(
                  onPressed: onPressed,
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          left: 16, top: 12, bottom: 12, right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        border: Border.all(
                          width: 2,
                          color: const Color(0xFF326CF9),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Yes',
                          style: baseTextStyle.copyWith(
                              color: const Color(0xFF326CF9),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          left: 16, top: 12, bottom: 12, right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        border: Border.all(
                          width: 2,
                          color: const Color(0xFF326CF9),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'No',
                          style: baseTextStyle.copyWith(
                              color: const Color(0xFF326CF9),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomNomineeModel {
  int? id;
  String nomineeFullName;
  DateTime nomineeDateOfBirth;
  String? guardianName;
  int? guardianRelationshipId;
  int? nomineeRelationTypeId;
  double allocationPercentage;

  _CustomNomineeModel({
    this.id,
    required this.nomineeFullName,
    required this.nomineeDateOfBirth,
    this.guardianName,
    this.guardianRelationshipId,
    this.nomineeRelationTypeId,
    required this.allocationPercentage,
  });

  _CustomNomineeModel copyWith({
    int? id,
    String? nomineeFullName,
    DateTime? nomineeDateOfBirth,
    String? guardianName,
    int? guardianRelationshipId,
    int? nomineeRelationTypeId,
    double? allocationPercentage,
  }) {
    return _CustomNomineeModel(
      id: id ?? this.id,
      nomineeFullName: nomineeFullName ?? this.nomineeFullName,
      nomineeDateOfBirth: nomineeDateOfBirth ?? this.nomineeDateOfBirth,
      guardianName: guardianName ?? this.guardianName,
      guardianRelationshipId:
          guardianRelationshipId ?? this.guardianRelationshipId,
      nomineeRelationTypeId:
          nomineeRelationTypeId ?? this.nomineeRelationTypeId,
      allocationPercentage: allocationPercentage ?? this.allocationPercentage,
    );
  }
}
