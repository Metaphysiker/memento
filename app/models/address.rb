class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  audited

  def country_name
    country = ISO3166::Country[self.country]
    country.translations[I18n.locale.to_s] || country.name
  end

end
