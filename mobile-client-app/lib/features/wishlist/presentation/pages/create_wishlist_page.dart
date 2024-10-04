import 'package:desiroo/core/constants/styled_constants.dart';
import 'package:desiroo/core/widgets/styled_text_field.dart';
import 'package:desiroo/features/wishlist/bloc/wishlist_cubit.dart';
import 'package:desiroo/features/wishlist/bloc/wishlists_cubit.dart';
import 'package:desiroo/features/wishlist/models/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateWishlistPage extends StatefulWidget {
  final String? id;
  final WishlistModel? wishlist;

  const CreateWishlistPage({
    super.key,
    this.id,
    this.wishlist,
  });

  @override
  State<CreateWishlistPage> createState() => _CreateWishlistPageState();
}

class _CreateWishlistPageState extends State<CreateWishlistPage> {
  final _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController.text = widget.wishlist?.Name ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: StyledConstants.edgeInsetsVertical,
                horizontal: StyledConstants.edgeInsetsHorizontal),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Text(
                            widget.id == null
                                ? 'Create new wishlist'
                                : 'Edit wishlist',
                            style: StyledConstants.headerTextStyle.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Flexible(
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
                  StyledTextField(
                    placeholder: 'Wishlist name',
                    controller: _nameController,
                    validator: (value) {
                      return value != null && value.isNotEmpty
                          ? null
                          : 'Name is required';
                    },
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    child: Text(widget.id == null ? 'Create' : 'Update'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.id == null
                            ? context
                                .read<WishlistsCubit>()
                                .createWishlist(_nameController.text)
                            : context
                                .read<WishlistCubit>()
                                .editWishlist(_nameController.text, widget.id);
                        context.read<WishlistsCubit>().getWishlists();
                        GoRouter.of(context).pop();
                      }
                    },
                  ),
                  widget.id != null
                      ? TextButton(
                          child: const Text('Delete'),
                          onPressed: () {
                            context
                                .read<WishlistCubit>()
                                .deleteWishlist(widget.id);
                            context.read<WishlistsCubit>().getWishlists();
                            GoRouter.of(context).go('/wishlists');
                          },
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
