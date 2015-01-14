Deface::Override.new(virtual_path: "spree/admin/shared/_product_tabs",
                     name: "add_sale_prices_tab",
                     insert_bottom: "[data-hook='admin_product_tabs']",
                     text: "<%= content_tag :li, :class => ('active' if current == Spree.t(:product_sale_prices)) do %><%= link_to_with_icon 'usd', Spree.t(:product_sale_prices), admin_product_sale_prices_path(@product) %><% end %>",
                     disabled: false)

Deface::Override.new(virtual_path: "spree/admin/products/_form",
                     name: "sale_price_details",
                     insert_top: "[data-hook='admin_product_form_right']",
                     text: "<%= ( Spree.t(:on_sale_from) + @product.display_price.to_html) if @product.on_sale? %>",
                     disabled: false)

Deface::Override.new(virtual_path: "spree/admin/products/_form",
                     name: "replace_master_price_if_sale",
                     replace: "erb[loud]:contains('f.text_field :price')",
                     text: "<%= f.text_field :price, :value => number_to_currency(@product.original_price, :unit => '') %>",
                     disabled: false)

Deface::Override.new(virtual_path: "spree/admin/variants/_form",
                     name: "replace_variant_price_if_sale",
                     replace: "erb[loud]:contains('f.text_field :price')",
                     text: "<%= f.text_field :price, :value => number_to_currency(@variant.original_price, :unit => ''), :class => 'fullwidth' %>",
                     disabled: false)