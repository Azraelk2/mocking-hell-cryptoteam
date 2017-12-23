require 'simplecov'

SimpleCov.start

RSpec.configure do |config|
  config.before(:all) { silence_output }
  config.after(:all) { enable_output }
  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
end

def silence_output
  @orig_stderr = $stderr
  @orig_stdout = $stdout
  $stderr = File.new('/dev/null', 'w')
  $stdout = File.new('/dev/null', 'w')
end

def enable_output
  $stderr = @orig_stderr
  $stdout = @orig_stdout
  @orig_stderr = nil
  @orig_stdout = nil
end

def random_name
  ('a'..'z').to_a.sample(6).join
end
