import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/category_models.dart';

class CategoryService{
  Future<List<CategoryModel>> getCategory() async{
    try{
      final response = await Supabase.instance.client.from('categories').select().order('id',ascending: true);
      return response.map((item)=> CategoryModel.fromJson(item)).toList();
    }catch(e){
      if (kDebugMode) {
        print("Error: $e");
      }
      return[];
    }
  }
}