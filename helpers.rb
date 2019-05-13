
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
        text.split(" ").first.downcase
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
    str.gsub('<','').gsub('>','').split(" ").first.start_with?('/')
  end
end

def is_self_closing_tag(str)
  self_closing_tags = ["area","base","br","col","embed","hr","img","input","link","meta","param","source","track","wbr","command","keygen","menuitem"]
  tag_from_str = tag_from(str)
  if tag_from_str == nil
    nil
  else
    self_closing_tags.include?(tag_from_str)
  end
end


