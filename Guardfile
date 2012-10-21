# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'spork', :cucumber_env => { 'RAILS_ENV' => 'test' }, :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch('config/routes.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
  watch('test/test_helper.rb') { :test_unit }
  watch(%r{features/support/}) { :cucumber }
  watch('app/controllers/application_controller.rb') { :rspec }
  watch(%r{^app/(.+)\.rb}) { :rspec }
  watch(%r{^app/(.*)(\.erb|\.haml)$}) { :rspec }
  watch(%r{^lib/(.+)\.rb}) { :rspec }
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$}) { :rspec }
end

guard 'rspec', :version => 2, :cli => '--format nested --drb', :all_after_pass => false do
  watch('spec/spec_helper.rb')                        { "spec" }
  watch('spec/factories/factory.rb')                  { "spec" }
  watch(%r{^spec/.+_spec\.rb})
  watch('config/routes.rb')                           { "spec/routing" }

  watch(%r{^app/controllers/(.+)_(controller)\.rb})   { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/requests/#{m[1]}_spec.rb"] }
end

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)/assets/\w+/(.+\.(css|js|html)).*})  { |m| "/assets/#{m[2]}" }
end
