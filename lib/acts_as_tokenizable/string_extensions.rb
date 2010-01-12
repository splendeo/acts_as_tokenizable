String.class_eval do
  
  #converts accented letters into ascii equivalents (i.e. ñ becomes n)
  def normalize
    #this version is in the forums but didnt work for me
    #string = string.chars.normalize(:kd).gsub!(/[^\x00-\x7F]/n,'').to_s
    mb_chars.normalize(:d).gsub(/[^\x00-\x7F]/n,'').to_s
  end
  
  #returns true if numeric, false, otherwise
  def numeric?
    true if Float(self) rescue
    return false
  end
  
  #returns an array of strings containing the words on this string. removes spaces, strange chars, etc
  def words
    gsub(/\W/, ' ').split
  end
  
  #removes certain words from a string. 
  # As a side-effect, all word-separators are converted to the separator char
  def remove_words(words_array, separator = ' ')
    (words - words_array).join separator
  end
  
  # replaces certain words on a string. 
  # As a side-effect, all word-separators are converted to the separator char
  def replace_words(replacements, separator = ' ')
    replaced_words = words
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
  def alphanumerics
    split(/(\d+)/).map { |v| v =~ /\d/ ? v.to_i : v }
  end
  
  #convert into something that can be used as an indexation key
  def to_token(max_length=255)
    string = self.normalize.strip.downcase.gsub(/\W/, '') #remove all non-alphanumeric
    string = string.squeeze unless string.numeric? #remove duplicates, except on pure numbers
    return string[0..(max_length-1)]
  end
  
  #convert into something that can be used on links
  def to_slug(separator='-')
    self.strip.downcase.normalize.words.join(separator)
  end
  
  #tokenizes each word individually, and joins the word with the separator char.
  def words_to_token(max_length=255, separator = ' ')
    words.collect{|w| w.to_token}.uniq.join(separator)[0..(max_length-1)]
  end
end
