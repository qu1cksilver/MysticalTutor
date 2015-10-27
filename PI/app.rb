# The primary requirement of a Sinatra application is the sinatra gem.
# If you haven't already, install the gem with 'gem install sinatra'
require 'sinatra'

require 'nokogiri'
require 'open-uri'

# sinatra allows us to respond to route requests with code.  Here we are 
# responding to requests for the root document - the naked domain.
get '/:produto' do
  # the first two lines are lifted directly from our previous script
  urlA = "http://www.mtgbrasil.com.br/index.php?route=product/search&search=#{params['produto']}"
  urlB = "http://letscollect.com.br/ecom.aspx/Buscar/#{params['produto']}"
  dataA = Nokogiri::HTML(open(urlA))
  dataB = Nokogiri::HTML(open(urlB))
  
  # this line has only be adjusted slightly with the inclusion of an ampersand
  # before concerts.  This creates an instance variable that can be referenced
  # in our display logic (view).
  @productA = dataA.css('.product-list > div')
  @productB = dataB.css('.dProduto')
  
  # this tells sinatra to render the Embedded Ruby template /views/shows.erb
  erb :shows
end