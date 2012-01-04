
Deface::Override.new(:virtual_path => "admin/products/_form",
                    :name => "admin_product_edit_volumes_override",
                    :insert_bottom => "div.right",
                    :partial => "admin/products/volumes",
                    :disabled => false)