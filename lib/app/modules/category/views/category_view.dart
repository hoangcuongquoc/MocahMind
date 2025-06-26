// views/category_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/category_models.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: Get.back,
        ),
        title: const Text('Category',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFF2E2E2E),
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // ── SEARCH BOX ────────────────────────────────────────────────
            TextField(
              onChanged: controller.onSearchChanged,      // <─ mới
              decoration: InputDecoration(
                hintText: 'Search Category',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[850],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            // ── GRID ─────────────────────────────────────────────────────
            Expanded(
              child: Obx(
                    () => GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                    MediaQuery.of(context).size.width > 500 ? 4 : 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: controller.filteredData.length,
                  itemBuilder: (_, i) =>
                      CategoryCard(category: controller.filteredData[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// widgets/category_card.dart
class CategoryCard extends StatefulWidget {
  final CategoryModel category;
  const CategoryCard({super.key, required this.category});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final radius = 16.0;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: () {
          Get.toNamed('/category-details', arguments: {
            'id': widget.category.id,
            'name': widget.category.name,
          });

        },
        onHighlightChanged: (v) => setState(() => _hover = v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                boxShadow: _hover
                    ? [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.45),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
                    : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: Image.network(
                  widget.category.image_url,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[700],
                    child: const Icon(Icons.broken_image,
                        color: Colors.white54, size: 40),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
