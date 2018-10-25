Deface::Override.new(virtual_path:  "spree/admin/shared/_product_tabs",
                     name:          "add_sale_prices_tab",
                     insert_bottom: "[data-hook='admin_product_tabs']",
                     partial:       "spree/admin/sale_prices/product_tab",
                     disabled:      false)
