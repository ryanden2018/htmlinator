# Tokenize an HTML document represented as a string.


# TODO: delete comments of all types in JS, CSS, HTML, before proceeding to tokenization

def tokenize(htmldoc)
  quotes = '\'"'
  quote = nil
  in_tag = false
  in_script = false
  in_css = false
  escaped = false

  tokens = []

  i = 0
  token = ""

  while i < htmldoc.length
    if in_script && token.downcase.include?("</script") && (htmldoc[i] == '>')
      in_script = false
      quote = nil
      in_tag = false
      in_css = false
      escaped = false
      token << htmldoc[i]
      tokens << token
      token = ""
    elsif in_css && token.downcase.include?("</style") && (htmldoc[i] == '>')
      in_css = false
      in_script = false
      quote = nil
      in_tag = false
      escaped = false
      token << htmldoc[i]
      tokens << token
      token = ""
    elsif quote
      if (htmldoc[i] == quote) && (!in_script || !escaped)
        quote = nil
      end
      
      if escaped
        escaped = false
      else
        if (htmldoc[i] == '\\') && in_script
          escaped = true
        end
      end

      token << htmldoc[i]
    elsif quotes.include?(htmldoc[i])
      quote = htmldoc[i]
      token << htmldoc[i]
    elsif in_tag && (htmldoc[i] == '>')
      in_tag = false
      token << htmldoc[i]

      if token.downcase.start_with?('<script')
        in_script = true
      elsif token.downcase.start_with?('<style')
        in_css = true
      else
        tokens << token
        token = ""
      end
    elsif (htmldoc[i] == '<') && !in_script && !in_css
      in_tag = true
      tokens << token
      token = htmldoc[i]
   else
      token << htmldoc[i]
    end


    i += 1
  end

  tokens << token


  tokens.delete_if { |s| s.length == 0 }
end

