require 'json'
require 'yaml'

Dir.glob('/mnt/cpdoc/depr/meta/*.meta') do |md_file|
  puts File.basename(md_file, ".meta")
  yml = File.read(md_file)
  data = YAML::load(yml)
  proc = {}
  if File.exist?("/mnt/cpdoc/depr/text/" + File.basename(md_file, ".meta") + ".text")
    data["content"] = File.read("/mnt/cpdoc/depr/text/" + File.basename(md_file, ".meta") + ".text")
  end
  if File.exist?("/mnt/cpdoc/depr/ref/" + File.basename(md_file, ".meta") + ".ref")
    data["ref"] = File.read("/mnt/cpdoc/depr/ref/" + File.basename(md_file, ".meta") + ".ref")
  end
  data["dic"]="depr"
  json = JSON.dump(data)
  
  File.open("/mnt/cpdoc/depr/json/"+File.basename(md_file, ".meta") + ".json", 'w') { |file| file.write(json) }
  # do work on files ending in .rb in the desired directory
  exec('grep -rl 'null' /mnt/cpdoc/depr/json/ | xargs sed -i 's/null/0/g'')
end

