require ::File.expand_path('../config/environment',  __FILE__)

if ENV['RAILS_RELATIVE_URL_ROOT']
  map ENV['RAILS_RELATIVE_URL_ROOT'] do
    run Ton9::Application
  end
else
  run Ton9::Application
end

