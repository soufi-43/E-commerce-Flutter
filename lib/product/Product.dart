import 'package:generalshop1/exceptions/exceptions.dart';
import 'package:generalshop1/review/product_review.dart';

import 'product_unit.dart';
import 'product_category.dart';
import 'product_tag.dart';

class Product {
  int product_id;

  String product_description, product_title;
  ProductUnit productUnit;

  double product_price, product_total, product_discount;

  ProductCategory productCategory;

  List<ProductTag> tags;

  List<String> images;

  List<ProductReview> reviews;

  Product(
      this.product_id,
      this.product_description,
      this.product_title,
      this.productUnit,
      this.product_price,
      this.product_total,
      this.product_discount,
      this.productCategory,
      this.tags,
      this.images,
      this.reviews);

  Product.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['product_id'] != null, 'Product ID is null');
    assert(jsonObject['product_title'] != null, 'Product Title is null');
    assert(jsonObject['product_description'] != null,
    'Product Description is null');
    assert(jsonObject['product_price'] != null, 'Product price is null');

    if (jsonObject['product_id'] == null) {
      throw PropertyIsRequired('product id');
    }
    if (jsonObject['product_title'] == null) {
      throw PropertyIsRequired('Product Title');
    }
    if (jsonObject['product_description'] == null) {
      throw PropertyIsRequired('Product description');
    }
    if (jsonObject['product_price'] == null) {
      throw PropertyIsRequired('Product price');
    }
    this.product_id = jsonObject['product_id'];
    this.product_title = jsonObject['product_title'];
    this.product_description = jsonObject['product_description'];
    this.product_price = double.tryParse(jsonObject['product_price']);
    this.product_discount = double.tryParse(jsonObject['product_discount']);
    this.product_total = double.tryParse(jsonObject['product_total']);
    this.productCategory =
        ProductCategory.fromJson(jsonObject['product_category']);
    this.tags = [];
    if (jsonObject['product_tags'] != null) {
      _setTags(jsonObject['product_tags']);
    }

    this.images = [];
    if (jsonObject['product_images'] != null) {
      _setImages(jsonObject['product_images']);
    }else{
      print('jhj');
    }

    this.reviews = [];
    if (jsonObject['product_reviews'] != null) {
      _setReviews(jsonObject['product_reviews']);
    }
  }

  void _setReviews(List<dynamic> reviewJson) {
    if (reviewJson.length > 0) {
      for (var item in reviewJson) {
        if (item != null) {
          this.reviews.add(ProductReview.fromJson(item));
        }
      }
    }
  }

  void _setTags(List<dynamic> tagsJson) {
    if (tagsJson.length > 0) {
      for (var item in tagsJson) {
        if (item != null) {
          tags.add(ProductTag.fromJson(item));
        }
      }
    }
  }

  void _setImages(List<dynamic> jsonImages) {
    images = [];
    if (jsonImages.length > 0) {
      for (var image in jsonImages) {
        if (image != 0) {
          this.images.add(image['image_url']);
        }
      }
    }
  }

  String featuredImage() {
    if (this.images.length > 0) {
      return this.images[0];
    } else {
      return 'https://cdn.pixabay.com/photo/2015/12/01/20/28/fall-1072821__340.jpg';
    }
  }
}
