import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../common/custom_styles.dart';
import '../../../../common/formatters.dart';
import '../../../../common/utils.dart';
import '../../../../common/validators.dart';
import '../../../../constants/dropdown_constants.dart';
import '../../../../constants/meta_strings.dart';
import '../../../../data/models/kyc/get_kyc_nominee_details_model.dart';
import '../../../../domain/entities/nominee_entity.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/onboarding/upload_nominee_details/upload_nominee_details_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_loader.dart';
import '../../../widgets/label_text.dart';
import '../../loading_screen.dart';

class ViewEditNomineeScreen extends StatefulWidget {
  const ViewEditNomineeScreen({Key? key}) : super(key: key);

  @override
  State<ViewEditNomineeScreen> createState() => _ViewEditNomineeScreenState();
}

class _ViewEditNomineeScreenState extends State<ViewEditNomineeScreen> {
  final _formKey = GlobalKey<FormState>();

  static final List<int?> nomIds = [null];
  static final List<String?> fullNames = [null];
  static final List<String?> dobs = [null];
  static final List<int?> relationIds = [null];
  static final List<double?> percentages = [null];
  static final List<String?> guardianNames = [null];
  static final List<int?> guardianRelationIds = [null];
  static final List<bool> isMinors = [false];

  @override
  void initState() {
    super.initState();
    _resetNomineeDataList();
  }

  void _resetNomineeDataList() {
    nomIds.clear();
    fullNames.clear();
    dobs.clear();
    relationIds.clear();
    percentages.clear();
    guardianNames.clear();
    guardianRelationIds.clear();
    isMinors.clear();
    nomIds.add(null);
    fullNames.add(null);
    dobs.add(null);
    relationIds.add(null);
    percentages.add(null);
    guardianNames.add(null);
    guardianRelationIds.add(null);
    isMinors.add(false);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nominee Details'),
        ),
        body:
            BlocConsumer<UploadNomineeDetailsCubit, UploadNomineeDetailsState>(
          listener: (context, state) {
            if (state is UploadNomineeDetailsSuccess && !state.isFetch) {
              Fluttertoast.showToast(
                  msg: 'Nominee details updated successfully');
              Navigator.pop(context);
            }
            if (state is UploadNomineeDetailsSuccess &&
                state.isFetch &&
                !state.isDelete) {
              List<GetKycNomineeDetailsModel> nomList = state.nomineeList!;

              for (int i = 0; i < nomList.length; i++) {
                if (i == 0) {
                  nomIds[i] = nomList[i].id;
                  fullNames[i] = nomList[i].nomineeFullName;
                  dobs[i] = DateFormat('dd-MM-yyyy')
                      .format(nomList[i].nomineeDateOfBirth);
                  relationIds[i] = nomList[i].nomineeRelationType.value;
                  percentages[i] = nomList[i].allocationPercentage;
                  guardianNames[i] = nomList[i].guardianName;
                  guardianRelationIds[i] =
                      nomList[i].guardianRelationship?.value;
                  isMinors[i] = nomList[i]
                      .nomineeDateOfBirth
                      .isAfter(DateTime(DateTime.now().year - 18));
                } else {
                  nomIds.add(nomList[i].id);
                  fullNames.add(nomList[i].nomineeFullName);
                  dobs.add(DateFormat('dd-MM-yyyy')
                      .format(nomList[i].nomineeDateOfBirth));
                  relationIds.add(nomList[i].nomineeRelationType.value);
                  percentages.add(nomList[i].allocationPercentage);
                  guardianNames.add(nomList[i].guardianName);
                  guardianRelationIds
                      .add(nomList[i].guardianRelationship?.value);
                  isMinors.add(nomList[i]
                      .nomineeDateOfBirth
                      .isAfter(DateTime(DateTime.now().year - 18)));
                }
              }
            }
            if (state is UploadNomineeDetailsSuccess && state.isDelete) {
              int index = state.deleteIndex!;
              nomIds.removeAt(index);
              fullNames.removeAt(index);
              dobs.removeAt(index);
              relationIds.removeAt(index);
              percentages.removeAt(index);
              guardianNames.removeAt(index);
              guardianRelationIds.removeAt(index);
              isMinors.removeAt(index);
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
                  child: AppErrorWidget(
                      errorType: state.appErrorType,
                      error: state.errorMessage));
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Add Nominees",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(5),
                        const Text(
                          'Please Add Nominees for your mutual fund investments',
                          textAlign: TextAlign.center,
                        ),
                        const Gap(30),
                        ..._buildNomineeList(),
                        const Gap(20),
                        if (fullNames.length != 3) _addNomineeButton(),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                //Check if sum of percentages is 100
                                if (percentages.reduce((a, b) => a! + b!) !=
                                    100) {
                                  Utils.showWarningAlert(context,
                                      'Total allocation percentage should be 100');
                                  return;
                                }
                                List<NomineeEntity> nominees = [];
                                for (int i = 0; i < fullNames.length; i++) {
                                  nominees.add(
                                    NomineeEntity(
                                        id: nomIds[i],
                                        nomineeFullName: fullNames[i]!.trim(),
                                        nomineeDateOfBirth:
                                            DateFormat("dd-MM-yyyy")
                                                .parse(dobs[i]!),
                                        nomineeRelationTypeId: relationIds[i],
                                        guardianName: isMinors[i]
                                            ? guardianNames[i]!.trim()
                                            : null,
                                        guardianRelationshipId: isMinors[i]
                                            ? guardianRelationIds[i]!
                                            : null,
                                        allocationPercentage: percentages[i]!),
                                  );
                                }

                                context
                                    .read<UploadNomineeDetailsCubit>()
                                    .uploadNomineeDetails(
                                        nomineeList: nominees);
                              }
                            },
                            child: const Text('Next')),
                      ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildNomineeList() {
    return List.generate(
        fullNames.length,
        (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nominee ${index + 1}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      ///delete button for even the first nominee if there are other nominees
                      if (nomIds.where((element) => element != null).length >
                              1 ||
                          index != 0)
                        _removeNomineeButton(index),
                    ],
                  ),
                  const Gap(10),
                  _NomineeFields(
                    index: index,
                  ),
                ],
              ),
            ));
  }

  Widget _addNomineeButton() => Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
            onPressed: () {
              setState(() {
                nomIds.add(null);
                fullNames.add(null);
                dobs.add(null);
                relationIds.add(null);
                percentages.add(null);
                guardianNames.add(null);
                guardianRelationIds.add(null);
                isMinors.add(false);
              });
            },
            icon: Assets.icons.addAccount.svg(
                colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            )),
            label: const Text('Add Nominee')),
      );

  Widget _removeNomineeButton(int index) => InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (ctx) => Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                              'Are you sure you want to remove this nominee?'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (nomIds[index] != null) {
                                    context
                                        .read<UploadNomineeDetailsCubit>()
                                        .deleteNomineeDetails(
                                            nomineeId: nomIds[index]!,
                                            index: index,
                                            isFromViewUpdate: true);
                                  } else {
                                    setState(() {
                                      nomIds.removeAt(index);
                                      fullNames.removeAt(index);
                                      dobs.removeAt(index);
                                      relationIds.removeAt(index);
                                      percentages.removeAt(index);
                                      guardianNames.removeAt(index);
                                      guardianRelationIds.removeAt(index);
                                      isMinors.removeAt(index);
                                    });
                                  }

                                  Navigator.of(ctx).pop();
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ));
        },
        child: const Icon(
          Icons.delete,
          color: AppColors.textRed,
        ),
      );
}

class _NomineeFields extends StatefulWidget {
  final int index;

  const _NomineeFields({Key? key, required this.index}) : super(key: key);

  @override
  State<_NomineeFields> createState() => _NomineeFieldsState();
}

class _NomineeFieldsState extends State<_NomineeFields> {
  late final TextEditingController _nameController;
  late final TextEditingController _dobController;
  late final TextEditingController _percentageController;
  late final TextEditingController _nomineeRelationController;
  late final TextEditingController _guardianNameController;
  late final TextEditingController _guardianRelationController;
  bool _isMinor = false;
  DateTime? _dob;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _dobController = TextEditingController();
    _percentageController = TextEditingController();
    _nomineeRelationController = TextEditingController();
    _guardianNameController = TextEditingController();
    _guardianRelationController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _percentageController.dispose();
    _nomineeRelationController.dispose();
    _guardianNameController.dispose();
    _guardianRelationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameController.text =
          _ViewEditNomineeScreenState.fullNames[widget.index] ?? '';
      _dobController.text =
          _ViewEditNomineeScreenState.dobs[widget.index] ?? '';
      _dob = _ViewEditNomineeScreenState.dobs[widget.index] != null
          ? DateFormat('dd-MM-yyyy')
              .parse(_ViewEditNomineeScreenState.dobs[widget.index]!)
          : null;
      _percentageController.text = _ViewEditNomineeScreenState
              .percentages[widget.index]
              ?.toStringAsFixed(0) ??
          '';
      _nomineeRelationController.text =
          _ViewEditNomineeScreenState.relationIds[widget.index]?.toString() ??
              '';
      _guardianNameController.text =
          _ViewEditNomineeScreenState.guardianNames[widget.index] ?? '';
      _guardianRelationController.text = _ViewEditNomineeScreenState
              .guardianRelationIds[widget.index]
              ?.toString() ??
          '';
      _isMinor = _ViewEditNomineeScreenState.isMinors[widget.index];
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelText(label: 'Full Name'),
        TextFormField(
          controller: _nameController,
          textCapitalization: TextCapitalization.words,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            _ViewEditNomineeScreenState.fullNames[widget.index] = value;
          },
          validator: (value) => Validators.validateEmptyField(
              ValidatorStrings.emptyNomineeFullNameField, value),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z .]')),
          ],
          textInputAction: TextInputAction.next,
        ),
        const Gap(25),
        const LabelText(label: 'Date of Birth'),
        TextFormField(
          controller: _dobController,

          // onTap: _selectDob,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            if (value.length == 10 && Validators.dobValidator(value) == null) {
              _ViewEditNomineeScreenState.dobs[widget.index] = value;
              var dob = DateFormat('dd-MM-yyyy').parse(value);
              _isMinor = dob.isAfter(DateTime(DateTime.now().year - 18,
                  DateTime.now().month, DateTime.now().day));
              _dob = dob;
              _ViewEditNomineeScreenState.isMinors[widget.index] = _isMinor;
              setState(() {});
            }
          },
          validator: (value) => Validators.dobValidator(value!),
          decoration: InputDecoration(
            hintText: 'DD-MM-YYYY',
            suffixIcon: IconButton(
              icon: Assets.icons.calendar.svg(),
              onPressed: _selectDob,
            ),
          ),
          keyboardType: TextInputType.datetime,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'\d'),
            ),
            LengthLimitingTextInputFormatter(10),
            DateTextFormatter(),
          ],
          textInputAction: TextInputAction.next,
        ),
        const Gap(25),
        ValueListenableBuilder(
          builder: (_, __, ___) => Column(
            children: [
              if (_isMinor) ...[
                const LabelText(
                  label: 'Guardian Name',
                ),
                TextFormField(
                  controller: _guardianNameController,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z .]')),
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => Validators.validateEmptyField(
                      ValidatorStrings.emptyNomineeGuardianNameField, value),
                  onChanged: (value) {
                    _ViewEditNomineeScreenState.guardianNames[widget.index] =
                        value;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const Gap(25),
                const LabelText(
                  label: 'Guardian Relation',
                ),
                ValueListenableBuilder(
                  builder: (ctx, value, child) => DropdownSearch<DropDownItem?>(
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: CustomStyles.dropDownDecoration,
                    ),
                    itemAsString: (DropDownItem? item) => item!.name,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (DropDownItem? item) =>
                        Validators.validateEmptyField(
                            ValidatorStrings.emptyNomineeGuardianRelationField,
                            item?.name),
                    popupProps: const PopupProps.menu(),
                    selectedItem: _guardianRelationController.text == ''
                        ? null
                        : DropDownConstants.nomineeRelationshipList.firstWhere(
                            (element) =>
                                element.value.toString() ==
                                _guardianRelationController.text),
                    items: DropDownConstants.nomineeRelationshipList,
                    onChanged: (DropDownItem? item) {
                      _guardianRelationController.text = item!.value.toString();
                      _ViewEditNomineeScreenState
                          .guardianRelationIds[widget.index] = item.value;
                    },
                  ),
                  valueListenable: _guardianRelationController,
                ),
                const Gap(25),
              ],
            ],
          ),
          valueListenable: _nameController,
        ),
        const LabelText(label: 'Relationship'),
        ValueListenableBuilder(
          builder: (ctx, value, child) => DropdownSearch<DropDownItem?>(
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: CustomStyles.dropDownDecoration,
            ),
            itemAsString: (DropDownItem? item) => item!.name,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            validator: (DropDownItem? item) => Validators.validateEmptyField(
                ValidatorStrings.emptyRelationToNomineeField, item?.name),
            popupProps: const PopupProps.menu(),
            selectedItem: _nomineeRelationController.text == ''
                ? null
                : DropDownConstants.nomineeRelationshipList.firstWhere(
                    (element) =>
                        element.value.toString() ==
                        _nomineeRelationController.text),
            items: DropDownConstants.nomineeRelationshipList,
            onChanged: (DropDownItem? item) {
              _nomineeRelationController.text = item!.value.toString();
              _ViewEditNomineeScreenState.relationIds[widget.index] =
                  item.value;
            },
          ),
          valueListenable: _nomineeRelationController,
        ),
        const Gap(25),
        const LabelText(label: 'Percentage'),
        TextFormField(
          controller: _percentageController,
          onChanged: (value) {
            _ViewEditNomineeScreenState.percentages[widget.index] =
                double.tryParse(value);
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

  void _selectDob() async {
    DateTime? pickedDob;
    pickedDob = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime.now().subtract(const Duration(days: 1)),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
    );
    if (pickedDob != null) {
      _dob = pickedDob;
      _dobController.text = DateFormat('dd-MM-yyyy').format(pickedDob);
      _ViewEditNomineeScreenState.dobs[widget.index] = _dobController.text;
      _isMinor = pickedDob.isAfter(DateTime(
          DateTime.now().year - 18, DateTime.now().month, DateTime.now().day));
      _ViewEditNomineeScreenState.isMinors[widget.index] = _isMinor;
      setState(() {});
    }
  }
}
