require 'config/environment'

def array_of_active_record_models
  Dir.glob(RAILS_ROOT + '/app/models/*.rb').each { |file| require file }

  models_with_token = ActiveRecord::Base.send(:subclasses).select{|m| m.respond_to?(:tokenized_by)}
end

def tokenize_records(records)
  total_count = records.size
  
  count = 0
  
  records.each do |record|
    record.tokenize     #this generates tokens
    record.save false   #this saves without checking validations
    count += 1
    print "\r#{count}/#{total_count}"
    GC.start if count % 1000 == 0 #launch garbage collection each 1000 registers
  end
  puts ""
end

def tokenize_models(regenerate = false)
  start = Time.now
  puts "Start token generation"
  puts "++++++++++++++++++++++++++++++++"
  
  array_of_active_record_models.each do |model|
  puts "Generating new tokens for #{model.name.pluralize}"
  
  conditions = "#{model.token_field_name} IS NULL OR #{model.token_field_name} = ''" unless regenerate

  records_without_token = model.all(:conditions => conditions)
    if records_without_token.size > 0 
      tokenize_records(records_without_token)
    else
      puts "There are no records without token"
      puts "++++++++++++++++++++++++++++++++"
    end
  end
  puts "Elapsed time " + (Time.now - start).seconds.to_s + " seconds"
  
end

namespace :tokens do
  desc "Generates the token for objects without tokens."
  task :generate => :environment do
    tokenize_models
  end
  
  desc "Re-builds the token for all objects."
  task :regenerate => :environment do
    tokenize_models(true)
  end
  
end