require 'json'
require 'yaml'
require 'net/http'
require 'rsolr'

count = 0
Dir.glob('/mnt/cpdoc/depr/json/*.json') do |js_file|
  solr = RSolr.connect :url => 'http://localhost:8983/solr/blacklight-core'
  jsonf = File.read(js_file)
  json = JSON.parse(jsonf, :quirks_mode => true) 
  json["id"]="depr" + File.basename(js_file,".json")
  json["url"]="http://nlp.emap.fgv.br/cpdoc/depr/"+File.basename(js_file,".json")+".html"
  solr.add json
  solr.commit
  puts count = count+1
  #puts File.basename(js_file, ".json")
  #ct="Content-Type:application/json"
  #url = URI.parse('http://localhost:8983/solr/blacklight-core/update/json')
  #post_args = { 'literal.id' => "doc"+File.basename(js_file, ".json"), 
	#	'commit' => true, '-H' => ct, '-F'=>"/mnt/cpdoc/json"+js_file}
  #resp,data = Net::HTTP.post_form(url,post_args)
  #puts resp
end


