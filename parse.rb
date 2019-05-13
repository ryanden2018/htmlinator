require_relative 'tokenizer.rb'
require_relative 'helpers.rb'

def parse_helper(tokens_with_depths)
  results = []

  if tokens_with_depths.length == 0
    return []
  end

  cur_depth = tokens_with_depths[0][1] 

  i = 0
  while i < tokens_with_depths.length
    token = tokens_with_depths[i][0]

    if is_opening_tag(token) && !is_self_closing_tag(token) && !token.include?("<script") && !token.include?("<style")
      contents = []
      while (i+1 < tokens_with_depths.length) && (tokens_with_depths[i+1][1] > cur_depth)
        i += 1
        contents << tokens_with_depths[i]
      end
      results << {token => parse_helper(contents)}
    elsif !is_closing_tag(token)
      results << {token => []}
    end

    i += 1
  end

  results
end

def parse(htmldoc)
  parse_helper(find_depths(htmldoc))
end


def find_depths(htmldoc)
  tokens = tokenize(htmldoc)

  tag_stack = []
  results = []

  i = 0
  while i < tokens.length
    token = tokens[i]
    tag = tag_from(token)
    if !tag || is_self_closing_tag(token)
      results << [token,tag_stack.length]
    else
      if is_opening_tag(token) && !is_self_closing_tag(token)
        results << [token,tag_stack.length]
        tag_stack << tag
      elsif is_closing_tag(token)
        until (tag_stack.pop==tag) || (tag_stack.length==0)
        end
        results << [token,tag_stack.length]
      end
    end

    i += 1
  end

  results
end

