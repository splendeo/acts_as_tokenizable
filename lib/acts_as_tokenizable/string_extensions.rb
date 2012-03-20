module ActsAsTokenizable

  module StringExtensions

    #converts accented letters into ascii equivalents (i.e. ñ becomes n)
    def self.normalize(str)
      str.mb_chars.normalize(:d).gsub(/[^\x00-\x7F]/n,'').to_s
    end

    #returns true if numeric, false, otherwise
    def self.numeric?(str)
      true if Float(str) rescue
      false
    end

    #returns an array of strings containing the words on this string. removes spaces, strange chars, etc
    def self.words(str)
      str.gsub(/[^\w|-]/, ' ').split
    end

    #removes certain words from a string.
    # As a side-effect, all word-separators are converted to the separator char
    def self.remove_words(str, words_array, separator = ' ')
      (words(str) - words_array).join separator
    end

    # replaces certain words on a string. 
    # As a side-effect, all word-separators are converted to the separator char
    def self.replace_words(str, replacements, separator = ' ')
      replaced_words = words(str)
      replacements.each do |candidates,replacement|
        candidates.each do |candidate|
          replaced_words=replaced_words.collect {|w| w==candidate ? replacement : w}
        end
      end
      replaced_words.join separator
    end

    # returns an array that contains, in order:
    #   * the numeric parts, converted to numbers
    #   * the non-numeric parts, as text
    # this is useful for sorting alphanumerically. For example:
    # ["A1", "A12", "A2"].sort_by{|x| x.alphanumerics} => ["A1", "A2", "A12"]
    #
    # inspired by : http://blog.labnotes.org/2007/12/13/rounded-corners-173-beautiful-code/
    def self.alphanumerics(str)
      str.split(/(\d+)/).map { |v| v =~ /\d/ ? v.to_i : v }
    end

    #convert into something that can be used as an indexation key
    def self.to_token(str, max_length=255)
      str = normalize(str).strip.downcase.gsub(/[^\w|-]/, '') #remove all non-alphanumeric but hyphen (-)
      str = str.squeeze unless numeric?(str) #remove duplicates, except on pure numbers
      return str[0..(max_length-1)]
    end

    #convert into something that can be used on links
    def self.to_slug(str, separator='-')
      words(normalize(str.strip.downcase)).join(separator)
    end

    #tokenizes each word individually, and joins the word with the separator char.
    def self.words_to_token(str, max_length=255, separator = ' ')
      words(str).collect{|w| to_token(w)}.uniq.join(separator)[0..(max_length-1)]
    end
  end
end
