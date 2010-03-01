require 'acts_as_tokenizable/acts_as_tokenizable'

class ActiveRecord::Base
  def self.acts_as_tokenizable(field_name=:token)
    include ActsAsTokenizable
    self.token_field_name = field_name
    self.before_save :tokenize
  end
end
