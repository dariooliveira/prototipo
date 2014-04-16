require 'json'
require 'yaml'

Dir.glob('/mnt/cpdoc/dhbb/meta_flat/*.markdown') do |md_file|
  puts File.basename(md_file, ".markdown")
  yml = File.read(md_file)
  data = YAML::load(yml)
  proc = {}
  if File.exist?("/mnt/cpdoc/dhbb/text/" + File.basename(md_file, ".markdown") + ".text")
    data["content"] = File.read("/mnt/cpdoc/dhbb/text/" + File.basename(md_file, ".markdown") + ".text")
  end
  if File.exist?("/mnt/cpdoc/dhbb/ref/" + File.basename(md_file, ".markdown") + ".ref")
    data["ref"] = File.read("/mnt/cpdoc/dhbb/ref/" + File.basename(md_file, ".markdown") + ".ref")
  end
  data["dic"]="dhbb"

  json = JSON.dump(data)

  #json.each do |i|
  #  i.each do |j|
  #   if json[i][j] == null
  #      json[i][j] = " "
  #   end
  #  end 
  #end  
File.open("/mnt/cpdoc/dhbb/json/"+File.basename(md_file, ".markdown") + ".json", 'w') { |file| file.write(json) }

exec('grep -rl 'null' /mnt/cpdoc/dhbb/json/ | xargs sed -i 's/null/0/g'')
  # do work on files ending in .rb in the desired directory
end

