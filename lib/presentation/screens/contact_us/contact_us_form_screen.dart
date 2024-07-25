import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/custom_styles.dart';
import '../../../common/utils.dart';
import '../../../common/validators.dart';
import '../../../constants/dropdown_constants.dart';
import '../../../constants/meta_strings.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/contact_us/contact_us_form_cubit/contact_us_form_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import 'mail_sucess_screen.dart';

class ContactUsFormScreen extends StatefulWidget {
  const ContactUsFormScreen({super.key});

  @override
  State<ContactUsFormScreen> createState() => _ContactUsFormScreenState();
}

class _ContactUsFormScreenState extends State<ContactUsFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _queryDescriptionController;
  late String _queryDescription;
  DropDownItem? _queryCategory;
  final FocusNode queryDescriptionNode = FocusNode();
  final List<File> _images = [];

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  @override
  void initState() {
    _queryDescriptionController = TextEditingController();
    _queryDescription = "";
    queryDescriptionNode.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _queryDescriptionController.dispose();
    queryDescriptionNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactUsFormCubit, ContactUsFormState>(
      listener: (context, state) {
        if (state is ContactUsFormSucess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MailSucessScreen(),
            ),
          );
        }
        if (state is ContactUsFormFailure) {
          Utils.showErrorAlert(
            context,
            Utils.getErrorMessage(
              msg: state.errorMessage,
              errorType: state.errorType,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownSearch(
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration:
                          CustomStyles.contactUsDropdownDecoration,
                    ),
                    items: DropDownConstants.queryCategories,
                    selectedItem: _queryCategory,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => Validators.validateEmptyField(
                      ValidatorStrings.emptyQueryCategory,
                      value?.toString(),
                    ),
                    popupProps: PopupProps.menu(
                      itemBuilder: (context, DropDownItem item, isSelected) =>
                          ListTile(
                        title: Text(item.name),
                        selected: _queryCategory == item,
                      ),
                    ),
                    itemAsString: (DropDownItem? item) => item!.name,
                    onChanged: (DropDownItem? value) => _queryCategory = value,
                  ),
                ),
                Container(
                  height: 96,
                  margin: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    maxLines: 10,
                    controller: _queryDescriptionController,
                    onChanged: (value) {
                      setState(() {
                        _queryDescription = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Tell us about your concern',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.neutral[200],
                      ),
                      fillColor: Colors.white,
                      focusColor: AppColors.primary[500],
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.primary[50] ?? Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.primary[50] ?? Colors.white,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.primary[50] ?? Colors.white,
                        ),
                      ),
                      filled: true,
                    ),
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: queryDescriptionNode,
                    keyboardType: TextInputType.name,
                  ),
                ),
                _queryDescription == ""
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.categoryQuestions,
                              arguments: CategoryQuestionsArgs(
                                  title: "Related Articles",
                                  query: _queryDescription),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'We found some relevant articles. ',
                              style: TextStyle(
                                color: AppColors.neutral[200],
                                fontSize: 12,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'View >',
                                  style: TextStyle(
                                    color: AppColors.primary[500],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Add images',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' (optional)',
                          style: TextStyle(
                            color: AppColors.neutral[200],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length + 1,
                    itemBuilder: (context, index) {
                      if (index < _images.length) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            _images[index],
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return InkWell(
                          onTap: () {
                            _pickImage();
                          },
                          child: SizedBox(
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Assets.icons.addImageIcon.image(
                                  height: 16,
                                  width: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 20.0,
                                  ),
                                  child: Text(
                                    'Add more',
                                    style: TextStyle(
                                      color: AppColors.neutral[100],
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Image size/format restrictions',
                    style: TextStyle(
                      color: AppColors.neutral[200],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                queryDescriptionNode.unfocus();
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  context.read<ContactUsFormCubit>().submitForm(
                        category: _queryCategory!.name,
                        descriptionofquery: _queryDescription,
                        queryReferenceimages: _images,
                      );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        );
      },
    );
  }
}
