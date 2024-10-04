import 'dart:io';

import 'package:desiroo/core/constants/styled_constants.dart';
import 'package:desiroo/core/widgets/styled_filter_dropdown.dart';
import 'package:desiroo/core/widgets/styled_text_field.dart';
import 'package:desiroo/features/wishlist/bloc/product_cubit.dart';
import 'package:desiroo/features/wishlist/bloc/products_cubit.dart';
import 'package:desiroo/features/wishlist/models/product_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CreateProductPage extends StatefulWidget {
  final String? wishlistId;
  final ProductModel? product;

  const CreateProductPage({
    super.key,
    this.product,
    required this.wishlistId,
  });

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  File? _selectedImage;
  bool isImageUploaded = true;

  final _nameController = TextEditingController();
  final _linkController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _importanceCategory = 'Low';
  String _priceCategory = 'Low';

  @override
  void initState() {
    _nameController.text = widget.product == null ? '' : widget.product!.Name;
    _linkController.text = widget.product == null ? '' : widget.product!.Link;
    setState(() {
      _selectedImage =
          widget.product != null ? File(widget.product!.PhotoPath) : null;
    });
    super.initState();
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> takePictureAndSave() async {
    final XFile? picture = await _picker.pickImage(source: ImageSource.camera);
    if (picture == null) return;

    final String path = await _savePicture(picture);

    setState(() {
      _selectedImage = File(path);
    });
  }

  Future<String> _savePicture(XFile picture) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String appDirPath = appDir.path;
    final String fileName = '${const Uuid().v4()}.jpg';
    final File localImage =
        await File(picture.path).copy('$appDirPath/$fileName');
    return localImage.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: StyledConstants.edgeInsetsVertical,
                horizontal: StyledConstants.edgeInsetsHorizontal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 4,
                        child: Text(
                          widget.product?.ProductId == null
                              ? 'Create new product'
                              : 'Update product',
                          style: StyledConstants.headerTextStyle.copyWith(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            GoRouter.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Upload photo',
                  style: StyledConstants.headerTextStyle2,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        _pickImageFromGallery();
                      },
                      child: SvgPicture.asset('assets/images/gallery.svg'),
                    ),
                    MaterialButton(
                      onPressed: () {
                        takePictureAndSave();
                      },
                      child: SvgPicture.asset('assets/images/camera.svg'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                    child: _selectedImage != null
                        ? Image.file(
                            _selectedImage!,
                            width: 180,
                            height: 180,
                            alignment: Alignment.center,
                          )
                        : isImageUploaded
                            ? const SizedBox.shrink()
                            : Text(
                                'Photo is required',
                                style: StyledConstants.mainTextStyle.copyWith(
                                    color: Theme.of(context).colorScheme.error),
                              )),
                const SizedBox(height: 24),
                Text(
                  'Product name',
                  style: StyledConstants.headerTextStyle2,
                ),
                const SizedBox(height: 24),
                StyledTextField(
                  placeholder: 'Enter product Name',
                  controller: _nameController,
                  validator: (value) {
                    return value != null && value.isNotEmpty
                        ? null
                        : 'Name is required';
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Product link',
                  style: StyledConstants.headerTextStyle2,
                ),
                const SizedBox(height: 24),
                StyledTextField(
                  placeholder: 'Enter product link',
                  controller: _linkController,
                  validator: (value) {
                    return value != null && value.isNotEmpty
                        ? null
                        : 'Link is required';
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Price category',
                  style: StyledConstants.headerTextStyle2,
                ),
                const SizedBox(height: 24),
                StyledFilterDropdown(
                  dropdownValue: widget.product == null
                      ? 'Low'
                      : widget.product!.PriceCategory,
                  onDropdownChanged: (value) {
                    setState(() {
                      _priceCategory = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Product importance',
                  style: StyledConstants.headerTextStyle2,
                ),
                const SizedBox(height: 24),
                StyledFilterDropdown(
                  dropdownValue: widget.product == null
                      ? 'Low'
                      : widget.product!.GiftImportance,
                  onDropdownChanged: (value) {
                    setState(() {
                      _importanceCategory = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                FilledButton(
                  child: Text(widget.product?.ProductId == null
                      ? 'Add a product'
                      : 'Update product'),
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _selectedImage != null) {
                      if (widget.product == null) {
                        context.read<ProductCubit>().createProduct(ProductModel(
                              ProductId: const Uuid().v4(),
                              WishlistId: widget.wishlistId.toString(),
                              Name: _nameController.text,
                              Link: _linkController.text,
                              PriceCategory: _priceCategory,
                              GiftImportance: _importanceCategory,
                              PhotoPath: _selectedImage != null
                                  ? _selectedImage!.path
                                  : 'assets/images/wishlist_title',
                            ));
                        context
                            .read<ProductsCubit>()
                            .getProducts(widget.wishlistId ?? '');
                        GoRouter.of(context).pop();
                      } else {
                        context.read<ProductCubit>().updateProduct(ProductModel(
                              ProductId: widget.product!.ProductId,
                              WishlistId: widget.wishlistId.toString(),
                              Name: _nameController.text,
                              Link: _linkController.text,
                              PriceCategory: _priceCategory,
                              GiftImportance: _importanceCategory,
                              PhotoPath: _selectedImage != null
                                  ? _selectedImage!.path
                                  : 'assets/images/wishlist_title',
                            ));
                        context
                            .read<ProductsCubit>()
                            .getProducts(widget.wishlistId ?? '');
                        GoRouter.of(context).pop();
                      }
                    } else {
                      setState(() {
                        isImageUploaded = false;
                      });
                    }
                  },
                ),
                widget.product != null
                    ? TextButton(
                        child: const Text('Delete'),
                        onPressed: () {
                          context
                              .read<ProductCubit>()
                              .deleteProduct(widget.product!.ProductId);
                          context
                              .read<ProductsCubit>()
                              .getProducts(widget.wishlistId ?? '');
                          GoRouter.of(context).pop();
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ]),
      )),
    );
  }
}
