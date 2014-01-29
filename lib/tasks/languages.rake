require 'languages'

task :import_languages => :environment do
  Languages.import
end