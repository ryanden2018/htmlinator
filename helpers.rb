
# tag_from('<html>') # => 'html'
# tag_from('<a href="somepage.html">') # => 'a'
# tag_from('</a>') # => 'a'
# tag_from('plain text') # => nil 
def tag_from(str)
  letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
  numbers = '0123456789'
  if str.length < 2
    nil
  else
    if (str[0]=='<') && (str[-1]=='>')
      text = str.gsub('<','').gsub('>','').gsub('/','')
      if (text.length == 0) || !letters.include?(text[0])
        nil
      else
        text.split(" ").first
      end
    else
      nil
    end
  end
end

def is_opening_tag(str)
  if tag_from(str) == nil
    nil
  else
    !is_closing_tag(str)
  end
end

def is_closing_tag(str)
  if tag_from(str) == nil
    nil
  else
    str.split(" ").first.include?('/')
  end
end

