module ProfilesHelper
  def gender_options
    Profile.genders.keys.map { |k| [ I18n.t("enum.gender.#{k}"), k ] }
  end
end
