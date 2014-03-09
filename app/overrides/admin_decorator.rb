Deface::Override.new(virtual_path: "spree/admin/shared/_product_tabs",
                     name: "add_sale_prices_tab",
                     insert_bottom: "[data-hook='admin_product_tabs']",
                     text: "<%= content_tag :li, :class => ('active' if current == 'Product Sale Prices') do %><%= link_to_with_icon 'icon-edit', Spree.t(:product_sale_prices), admin_product_sale_prices_path(@product) %><% end %>",
                     disabled: false)

Deface::Override.new(virtual_path: "spree/admin/products/_form",
                     name: "sale_price_details",
                     insert_top: "[data-hook='admin_product_form_right']",
                     text: "<%= ('On sale from ' + display_original_price(@product)) if @product.on_sale? %>",
                     disabled: false)