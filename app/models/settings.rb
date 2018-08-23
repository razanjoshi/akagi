class Settings < Settingslogic
  source "#{Rails.root}/config/global_conf.yml"
  namespace Rails.env
end
