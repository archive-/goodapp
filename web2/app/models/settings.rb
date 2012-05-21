class Settings < Settingslogic
  source "#{Rails.root}/config/settings/settings.yml"
  namespace Rails.env
end
