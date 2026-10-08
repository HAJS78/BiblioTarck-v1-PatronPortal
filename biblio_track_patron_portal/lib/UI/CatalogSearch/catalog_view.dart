import 'package:biblio_track_patron_portal/UI/CatalogSearch/catalog_view_model.dart';
import 'package:biblio_track_patron_portal/UI/SharedWidgets/book_card.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_colors.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CatalogView extends StatefulWidget
{
  final int memberRecordID;

  const CatalogView({super.key, required this.memberRecordID});

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView>
{
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose()
  {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Library Catalog")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Browse By",style: AppTextStyles.body),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Consumer<CatalogViewModel>(
                      builder: (context, viewModel, child)
                      {
                        return DropdownButton<CatalogSearchFilter>(
                          isExpanded: true,
                          value: viewModel.selectedFilter,
                          items: CatalogSearchFilter.values.map((filter)
                          {
                            return DropdownMenuItem(
                              value: filter,
                              child: Text(filter.label),//
                            );
                          }).toList(),
                          onChanged: (filter)
                          {
                            if (filter != null)
                            {
                              viewModel.setSearchFilter(filter);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: "Search The Library Catalog",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: Consumer<CatalogViewModel>(
                    builder: (context, viewModel, child)
                    {
                      return Padding(
                        padding:  EdgeInsets.all(12.w),
                        child: viewModel.isSearching
                            ?  SizedBox(
                                width:16.w,
                                height: 16.h,
                                child: CircularProgressIndicator(strokeWidth: 2,color: AppColors.primary),
                              )
                            : const Icon(null),
                      );
                    },
                  ),
                ),
                onEditingComplete: () => _search(widget.memberRecordID),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: Consumer<CatalogViewModel>(
                  builder: (context, viewModel, child)
                  {
                    if (viewModel.errorMessage != null)
                    {
                      return Center(child: Text(viewModel.errorMessage!,style: AppTextStyles.errorMessage));
                    }

                    if (viewModel.catalogResults.isEmpty)
                    {
                      return Center(child: Text("No results yet. Try searching above.",style: AppTextStyles.subtitle));
                    }

                    return ListView.builder(
                      itemCount: viewModel.catalogResults.length,
                      itemBuilder: (context, index)
                      {
                        return BookCard(
                          title: viewModel.catalogResults[index].title,
                          author: viewModel.catalogResults[index].author,
                          bookCoverImageUrl: viewModel.catalogResults[index].bookCoverImageUrl,
                          inFavorites: viewModel.catalogResults[index].inFavorites,
                          isFavoriteLoading: viewModel.catalogResults[index].isFavoriteLoading,
                          onPressingFavoriteIcon: () => viewModel.handleFavoriteIconPressing(
                            viewModel.catalogResults[index].bookRecordID,
                            viewModel.catalogResults[index].title,
                            widget.memberRecordID,
                            viewModel.catalogResults[index].favoriteRecordID,
                          ),onTappingTheCard: ()=>context.push('/BookDetails',extra:{'memberRecordID':widget.memberRecordID,'bookRecordID':viewModel.catalogResults[index].bookRecordID}),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _search(int memberRecordId) async
  {
    final catalogViewModel = context.read<CatalogViewModel>();
    await catalogViewModel.searchCatalog(memberRecordId, _searchController.text);
  }
}