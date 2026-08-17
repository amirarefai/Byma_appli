import 'package:byma_app/business_logic/create_collection/cubit/create_collection_cubit.dart';
import 'package:byma_app/business_logic/create_collection/cubit/create_collection_state.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:byma_app/business_logic/collection/cubit/collection_cubit.dart';
import 'package:byma_app/business_logic/collection/cubit/collection_state.dart';
import 'package:byma_app/business_logic/delete_collection/cubit/delete_collection_cubit.dart';

import 'package:byma_app/data/models/collection_model.dart';
import 'collection_details_screen.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  void _showDeleteConfirmationDialog(
    BuildContext context,
    CollectionModel collection,
  ) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: theme.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          context.tr('Delete Collection'),
          style: TextStyle(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          context.tr('Are you sure you want to delete this collection?'),
          style: TextStyle(color: theme.colorScheme.secondary, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              context.tr('Cancel'),
              style: TextStyle(color: theme.colorScheme.tertiary),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              // Close the dialog first
              Navigator.pop(dialogContext);

              // 1. Optimistically remove from UI
              context.read<CollectionCubit>().deleteCollectionOptimistically(
                collection.id,
              );

              // 2. Trigger actual backend deletion API
              context.read<DeleteCollectionCubit>().deleteCollection(
                collection.id,
              );
            },
            child: Text(context.tr('Delete')),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Fetch collections from API when the screen initializes
    context.read<CollectionCubit>().fetchAllCollections();
  }

  void _showCreateCollectionDialog() {
    final theme = Theme.of(context);
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          context.tr('create_collection_title'),
          style: TextStyle(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: TextStyle(color: theme.colorScheme.secondary),
          decoration: InputDecoration(
            hintText: context.tr('collection_hint'),
            hintStyle: TextStyle(color: theme.colorScheme.tertiary),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: theme.dividerColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              context.tr('cancel_btn'),
              style: TextStyle(color: theme.colorScheme.tertiary),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              final collectionName = controller.text.trim();
              if (collectionName.isNotEmpty) {
                // 1. Trigger the Create Collection API call
                context.read<CreateCollectionCubit>().createCollection(
                  collectionName,
                );

                // 2. Close the dialog
                Navigator.pop(context);
              }
            },
            child: Text(context.tr('create_btn')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<CreateCollectionCubit, CreateCollectionState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () {
            // Refresh the grid to display the newly created collection
            context.read<CollectionCubit>().fetchAllCollections();
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            context.tr('collections_appbar_title'),
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
        ),
        body: BlocBuilder<CollectionCubit, CollectionState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        color: theme.colorScheme.error,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<CollectionCubit>().fetchAllCollections(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              success: (collections) {
                if (collections.isEmpty) {
                  return Center(
                    child: Text(
                      context.tr('no_collections'),
                      style: TextStyle(
                        color: theme.colorScheme.tertiary,
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: collections.length,
                  itemBuilder: (context, index) {
                    // 2. Pass context into _buildCollectionCard
                    return _buildCollectionCard(
                      collections[index],
                      theme,
                      context,
                    );
                  },
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: theme.colorScheme.primary,
          onPressed: _showCreateCollectionDialog,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  // 3. Added BuildContext context parameter
  Widget _buildCollectionCard(
    CollectionModel collection,
    ThemeData theme,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CollectionDetailsScreen(collection: collection),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.dividerColor, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  // Folder Icon Background
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.dividerColor.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.folder_special_outlined,
                        size: 50,
                        color: theme.colorScheme.primary.withOpacity(0.7),
                      ),
                    ),
                  ),

                  // Delete Button (Top-Right Corner)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          // Show confirmation dialog before deleting
                          _showDeleteConfirmationDialog(context, collection);
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: theme.cardColor.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: theme.dividerColor),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.delete_outline_rounded,
                              color: theme.colorScheme.error,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collection.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
