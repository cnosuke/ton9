# coding: utf-8
require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'factories/factory.rb'
  #require 'database_cleaner'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.include FactoryGirl::Syntax::Methods

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"

    # database cleaner
    # config.before(:suite) do
    #   DatabaseCleaner.strategy = :transaction
    #   DatabaseCleaner.clean_with(:truncation)
    # end

    # config.before(:each) do
    #   DatabaseCleaner.start
    # end

    # config.after(:each) do
    #   DatabaseCleaner.clean
    # end
  end

  # spec/spec_helper.rb
  # FactoryGirlのデータがvalidであることをテスト
  def sample_is_valid sample_name, data_hash = {}
    it "#{sample_name}#{data_hash}のとき保存される" do
      sample = FactoryGirl.build sample_name, data_hash
      sample.should be_valid
    end 
  end

  # usage:
  # unsample_is_not_valid :bad_sample
  # unsample_is_not_valid :good_sample, name: nil
  def unsample_is_not_valid(sample_name, data_hash = {}) 
    it "#{sample_name}#{data_hash}のとき保存されない" do
      sample = FactoryGirl.build sample_name, data_hash
      sample.should_not be_valid
    end 
  end

  def non_uniq_is_not_valid(sample_name, column_name)
    it "#{sample_name}で#{column_name}が重複しているとき保存されない" do
      sample1 = FactoryGirl.create sample_name
      sample2 = FactoryGirl.build sample_name, column_name => sample1.send(column_name)
      sample2.should_not be_valid
    end
  end

  def unsample_is_not_valid_for_char_count(sample_name, column_name, count)
    it "#{sample_name}で#{column_name}が#{count}文字のとき保存されない" do
      sample = FactoryGirl.build sample_name, column_name => ("a" * count)
      sample.should_not be_valid
    end
  end
end

Spork.each_run do
  Ton9::Application.reload_routes!
  FactoryGirl.reload
end
