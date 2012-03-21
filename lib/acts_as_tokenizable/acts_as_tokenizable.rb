require 'acts_as_tokenizable/string_utils'

module ActsAsTokenizable

  # default to_token method. needs to have a "name" property on the object.
  # override for more complex token generation
  def to_token
    raise NoMethodError.new("You must redefine to_token in your model. Example: self.name.to_token()")
  end

  #makes self.<token_field_name>=self.to_token
  def tokenize
    self.send("#{self.class.token_field_name}=", self.to_token)
  end

  module ClassMethods
    attr_accessor :token_field_name

    # search_token parameter is used by tokenized_by. This function allows for preparation
    # before tokenized_by function is invoked. Usually this means removing
    # stop words, replacing words.
    # By default it tokenizes each word and removes duplicates.
    def prepare_search_token(search_token)
      StringUtils.words_to_token(search_token)
    end
  end

  def self.included(base)
    base.class_eval do
      extend ClassMethods

      scope :tokenized_by, lambda {|search_token|
        search_strings = []
        search_values = []
        StringUtils.words(prepare_search_token(search_token)).each do |w|
          if w[0,1] == '-'
            search_strings.push("#{table_name}.#{token_field_name} NOT LIKE ?")
            search_values.push("%#{w[1,w.length]}%")
          else
            search_strings.push("#{table_name}.#{token_field_name} LIKE ?")
            search_values.push("%#{w}%")
          end
        end
        where([search_strings.join(' AND '), *search_values])
      }
    end
  end
end
