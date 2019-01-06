class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  audited

  ADDRESS_ATTRIBUTES = %w{line1 line2 line3 line4 line5 street plz location country}

  def country_name
    country = ISO3166::Country[self.country]
    country.translations[I18n.locale.to_s] || country.name
  end

end
