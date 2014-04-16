require 'json'
require 'yaml'

Dir.glob('/mnt/cpdoc/meta_dario/*.markdown') do |md_file|
  puts File.basename(md_file, ".markdown")
  yml = File.read(md_file)
  data = YAML::load(yml)
  if File.exist?("/mnt/cpdoc/verbete/text/" + File.basename(md_file, ".markdown") + ".text")
    data["content"] = File.read("/mnt/cpdoc/verbete/text/" + File.basename(md_file, ".markdown") + ".text")
  end
  File.open("/mnt/cpdoc/yaml/"+File.basename(md_file, ".markdown") + ".yaml", 'w') { |file| file.write(data) }
  doc = String.new
  File.open( "/mnt/cpdoc/yaml/"+File.basename(md_file, ".markdown") + ".yaml" ) { |yf| doc << YAML::parse(yf).transform.to_xml }
  File.open( "/mnt/cpdoc/xml/"+File.basename(md_file, ".markdown") + ".xml", 'w' ) { |f| f.write( doc ) }
  # do work on files ending in .rb in the desired directory
end

