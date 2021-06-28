SALES_ENTRY_HEADERS_VALID = [:purchaser_name, :item_description, :item_price, :purchase_count, :merchant_address, :merchant_name].freeze
SALES_ENTRY_HEADERS_INVALID = [:purchasr_nome, :item_description, :item_price, :purchase_amount, :merchant_address, :merchant_nams, :random_column].freeze

SALES_ENTRY_DATA_VALID = [['João Silva', 'R$10 off R$20 of food', 10.0, 2, '987 Fake St', "Bob's Pizza"]].freeze
SALES_ENTRY_DATA_INVALID = [['João Silva', 'R$10 off R$20 of food', 'not coercible to decimal', 'not coercible to integer', '987 Fake St', "Bob's Pizza"]].freeze