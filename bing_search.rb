require 'rest-client'

def get_search_content
  reserved_characters = {'!'=>'%21',	'#'=>'%23', '$'=>'%24', '&'=>'%26',
                       "'"=>'%27', '('=>'%28', ')'=>'%29', '*'=>'%2A'	,
                       '+'=>'%2B', ','=>'%2C', '/'=>'%2F', ':'=>'%3A',
                       ';'=>'%3B', '='=>'%3D', '?'=>'%3F', '@'=>'%40',
                       '['=>'%5B', ']'=>'%5D'}
  puts "What do you want to search in Bing?"
  search_content = gets.chomp.split('')
  search_content.map! do |character|
    if reserved_characters.keys.include?(character)
      character = reserved_characters[character]
    else
      character
    end
  end
  search_content.join('').scan(/\S+/).join('+')
end

search_url = "https://www.bing.com/search?q=#{get_search_content}"
search_result_filename = 'search.html'
response = RestClient.get(search_url)

File.open(search_result_filename, "w") do |file|
   file.write(response)
end

puts "your search response.code = #{response.code}"
puts "Your bing's search is saved as search.html, please kindly check!"
