class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  audited

  ADDRESS_ATTRIBUTES = %w{line1 line2 line3 line4 line5 street plz location country}

  def country_name
    country = ISO3166::Country[self.country]
    country.translations[I18n.locale.to_s] || country.name
  end

  def address_for_letter
    address_text = addressable.name

    address_text = address_text +  "\n" + line1 unless line1.blank?
    address_text = address_text +  "\n" + line2 unless line2.blank?
    address_text = address_text +  "\n" + line3 unless line3.blank?
    address_text = address_text +  "\n" + line4 unless line4.blank?
    address_text = address_text +  "\n" + line5 unless line5.blank?
    address_text = address_text +  "\n" + street unless street.blank?

    plz_with_location = ""
    unless plz.blank?
      plz_with_location = plz_with_location + plz + " "
    end
    unless location.blank?
      plz_with_location = plz_with_location + location
    end

    address_text = address_text +  "\n" + plz_with_location unless plz_with_location.blank?

    address_text = address_text +  "\n" + country_name unless (country.blank? || country == "CH")

    address_text
  end

end
