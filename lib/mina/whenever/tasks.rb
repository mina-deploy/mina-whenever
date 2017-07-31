set :whenever_name, -> { "#{fetch(:domain)}_#{fetch(:rails_env)}" }

namespace :whenever do

  # ### whenever_sets
  # Pass optional name=value pairs to the --set argument of whenever.
  # Specify these in your deploy.rb as key/value pairs, for example:
  #     set :whenever_sets, host: ENV['HOST']

  sets = lambda { whenever_sets || {} }

  set_string = lambda do
    ["environment=#{fetch(:rails_env)}",
     "path=#{fetch(:current_path)}",
     sets.call.map { |k, v| "#{k}=#{v}" }].flatten.join('&')
  end

  desc 'Clear crontab'
  task clear: :environment do
    comment "Clear contrab for #{fetch(:whenever_name)}"
    in_path fetch(:current_path) do
      command "#{fetch(:bundle_bin)} exec whenever --clear-crontab #{fetch(:whenever_name)} --set '#{set_string.call}'"
    end
  end

  desc 'Update crontab'
  task update: :environment do
    comment "Update crontab for #{fetch(:whenever_name)}"
    in_path fetch(:current_path) do
      command "#{fetch(:bundle_bin)} exec whenever --update-crontab #{fetch(:whenever_name)} --set '#{set_string.call}'"
    end
  end

  desc 'Write crontab'
  task write: :environment do
    comment "Write crontab for #{fetch(:whenever_name)}"
    in_path fetch(:current_path) do
      command "#{fetch(:bundle_bin)} exec whenever --write-crontab #{fetch(:whenever_name)} --set '#{set_string.call}'"
    end
  end
end
