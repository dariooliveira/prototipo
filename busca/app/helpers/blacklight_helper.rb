require 'kramdown' 

module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior
  def link_to_document (doc, opts={:label=>nil, :counter => nil})
    #link_to doc['attr_reporturl'], doc['id']
    opts[:label] ||= blacklight_config.index.show_link.to_sym
    label = render_document_index_label doc, opts
    link_to label, doc, search_session_params(opts[:counter]).merge(opts.reject { |k,v| [:label, :counter].include? k  })
    #link_to doc['id'], doc['url']
  end
  def to_html args
    Kramdown::Document.new(args[:document][args[:field]]).to_html
  end
end
