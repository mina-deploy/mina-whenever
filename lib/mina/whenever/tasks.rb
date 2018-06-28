set :whenever_environment_variable, -> { fetch(:environment_variable) || 'RAILS_ENV' }
set :whenever_environment, -> { fetch(fetch(:environment_variable).downcase.to_sym) }
set :whenever_name, -> { "#{fetch(:domain)}_#{fetch(:whenever_environment)}" }

namespace :whenever do
  desc 'Clear crontab'
  task clear: :environment do
    comment "Clear contrab for #{fetch(:whenever_name)}"
    in_path fetch(:current_path) do
      command "#{fetch(:bundle_bin)} exec whenever --clear-crontab #{fetch(:whenever_name)} --set 'environment_variable=#{fetch(:whenever_environment_variable)}&environment=#{fetch(:whenever_environment)}&path=#{fetch(:current_path)}'"
    end
  end

  desc 'Update crontab'
  task update: :environment do
    comment "Update crontab for #{fetch(:whenever_name)}"
    in_path fetch(:current_path) do
      command "#{fetch(:bundle_bin)} exec whenever --update-crontab #{fetch(:whenever_name)} --set 'environment_variable=#{fetch(:whenever_environment_variable)}&environment=#{fetch(:whenever_environment)}&path=#{fetch(:current_path)}'"
    end
  end

  desc 'Write crontab'
  task write: :environment do
    comment "Write crontab for #{fetch(:whenever_name)}"
    in_path fetch(:current_path) do
      command "#{fetch(:bundle_bin)} exec whenever --write-crontab #{fetch(:whenever_name)} --set 'environment_variable=#{fetch(:whenever_environment_variable)}&environment=#{fetch(:whenever_environment)}&path=#{fetch(:current_path)}'"
    end
  end
end
