# -*- encoding : utf-8 -*-
#
require 'kramdown'
require 'htmlentities'
class CatalogController < ApplicationController  
  #include Blacklight::Marc::Catalog
  #include Maruku
  include Blacklight::Catalog

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = { 
      :qt => 'search',
      :rows => 30 
    }
    
    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SolrHelper#solr_doc_params) or 
    ## parameters included in the Blacklight-jetty document requestHandler.
    #
    #config.default_document_solr_params = {
    #  :qt => 'document',
    #  ## These are hard-coded in the blacklight 'document' requestHandler
    #  # :fl => '*',
    #  # :rows => 1
    #  # :q => '{!raw f=id v=$id}' 
    #}

    # solr field configuration for search results/index views
    config.index.title_field = 'title_display'
    config.index.display_type_field = 'format'

    config.index.show_link = 'url'
    config.index.record_display_type = 'format'

    # solr field configuration for document/show views
    config.show.html_title = 'title'
    config.show.heading = 'title_display'
    config.show.display_type = 'format'
    # solr field configuration for document/show views
    config.show.title_field = 'title_display'
    config.show.display_type_field = 'format'
   
    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.    
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or 
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.  
    #
    # :show may be set to false if you don't want the facet to be drawn in the 
    # facet bar
    config.add_facet_field 'dic', :label => 'Dicionário'
    config.add_facet_field 'type', :label => 'Tipo'
    config.add_facet_field 'published', :label => 'Publicado'
    config.add_facet_field 'subtype', :label => 'Sub-Tipo', :limit => true
    config.add_facet_field 'edition', :label => 'Edição'
    config.add_facet_field 'cargoss', :label => 'Cargo', :limit => true
    config.add_facet_field 'funcoes', :label => 'Função Cargo', :limit => true
    config.add_facet_field 'cities', :label => 'Cidade', :limit => true
    config.add_facet_field 'ufs', :label => 'Estado', :limit => true
    config.add_facet_field 'countries', :label => 'Pais', :limit => true
    config.add_facet_field 'institutions', :label => 'Instituição', :limit => true
    #config.add_facet_field 'example_query_facet_field2', :label => 'Cargo2', :query => { :q => 'cargoss:* OR cargo:*' }
    config.add_facet_field 'governments', :label => 'Governos', :limit => true
    config.add_facet_field 'pub_date', :label => 'Publication Year', :single => true
    config.add_facet_field 'subject_topic_facet', :label => 'Topic', :limit => 20 
    config.add_facet_field 'language_facet', :label => 'Language', :limit => true 
    config.add_facet_field 'lc_1letter_facet', :label => 'Call Number' 
    config.add_facet_field 'subject_geo_facet', :label => 'Region' 
    config.add_facet_field 'subject_era_facet', :label => 'Era'  
    config.add_facet_field 'author', :label => 'Autor', :limit => true
    config.add_facet_field 'example_pivot_field', :label => 'Pivot Field', :pivot => ['format', 'language_facet']
   
    #config.add_facet_field :ends, :date => { :format => :short }
    config.add_facet_field 'example_query_facet_field', :label => 'Anos de Atuação', :query => {
       :op0 => { :label => 'Pré 1900', :fq => "starts:[00000001 TO 18999999]" },
       :op1 => { :label => '1900-1920', :fq => "starts:[19000000 TO 19209999]" },
       :op2 => { :label => '1921-1940', :fq => "starts:[19210000 TO 19409999]" },
       :op3 => { :label => '1941-1960', :fq => "starts:[19410000 TO 19609999]" },
       :op4 => { :label => '1961-1980', :fq => "starts:[19610000 TO 19809999]" },
       :op5 => { :label => '1981-2000', :fq => "starts:[19810000 TO 20009999]" },
       :op6 => { :label => '2001 em diante', :fq => "starts:[20010000 TO 99999999]" }
    }


    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display 
    config.add_index_field 'dic', :label => 'Dicionário'
    config.add_index_field 'title', :label => 'Título'
    config.add_index_field 'published', :label => 'Publicado'
    config.add_index_field 'title_display', :label => 'Title'
    config.add_index_field 'author_display', :label => 'Author'
    config.add_index_field 'author_vern_display', :label => 'Author'
    config.add_index_field 'format', :label => 'Format'
    config.add_index_field 'language_facet', :label => 'Language'
    config.add_index_field 'published_display', :label => 'Published'
    config.add_index_field 'published_vern_display', :label => 'Published'
    config.add_index_field 'lc_callnum_display', :label => 'Call number'
    config.add_index_field 'content', :label => 'Conteúdo', :highlight => true
    config.add_index_field 'author', :label => 'Autor'

    config.add_field_configuration_to_solr_request!
    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display 
    #config.add_show_field 'title', :label => 'Título'
    config.add_show_field 'dic', :label => 'Dicionário'
    config.add_show_field 'title', :label => 'Título'
    config.add_show_field 'url', :label => 'URL'
    config.add_show_field 'published', :label => 'Publicado'
    config.add_show_field 'edition', :label => 'Edição'
    config.add_show_field 'cargoss', :label => 'Cargos'
    config.add_show_field 'cargo', :label => 'Cargos'
    #config.add_show_field 'cargo_types', :label => 'Tipo de Cargo'
    #config.add_show_field 'starts', :label => 'Início'
    #config.add_show_field 'ends', :label => 'Fim'
    #config.add_show_field 'cities', :label => 'Cidade'
    #config.add_show_field 'ufs', :label => 'UF'
    #config.add_show_field 'countries', :label => 'País'
    #config.add_show_field 'governments', :label => 'Governos'
    #config.add_show_field 'type', :label => 'Tipo'
    #config.add_show_field 'subtype', :label => 'Sub-Tipo'
    #config.add_show_field 'cargos', :label => 'Cargos'
    config.add_show_field 'content', :label => 'Conteúdo' #, :helper_method: => 'to_html'
    config.add_show_field 'ref', :label => 'Referências'
    config.add_show_field 'title_vern_display', :label => 'Title'
    config.add_show_field 'subtitle_display', :label => 'Subtitle'
    config.add_show_field 'subtitle_vern_display', :label => 'Subtitle'
    config.add_show_field 'author_display', :label => 'Author'
    config.add_show_field 'author_vern_display', :label => 'Author'
    config.add_show_field 'format', :label => 'Format'
    config.add_show_field 'url_fulltext_display', :label => 'URL'
    config.add_show_field 'url_suppl_display', :label => 'More Information'
    config.add_show_field 'language_facet', :label => 'Language'
    config.add_show_field 'published_display', :label => 'Published'
    config.add_show_field 'published_vern_display', :label => 'Published'
    config.add_show_field 'lc_callnum_display', :label => 'Call number'
    config.add_show_field 'isbn_t', :label => 'ISBN'
    config.add_show_field 'author', :label => 'Autor'
    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different. 

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise. 
    
    config.add_search_field 'all_fields', :label => 'Todos'
    

    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields. 
    
    config.add_search_field('title') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params.
      field.label = 'Título' 
      field.solr_parameters = { :'spellcheck.dictionary' => 'title' }
	
      # :solr_local_parameters will be sent using Solr LocalParams
      # syntax, as eg {! qf=$title_qf }. This is neccesary to use
      # Solr parameter de-referencing like $title_qf.
      # See: http://wiki.apache.org/solr/LocalParams
      field.solr_local_parameters = { 
        :qf => '$title_qf',
        :pf => '$title_pf'
      }
    end

    config.add_search_field('content') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params.
      field.label = 'Conteúdo'
      #field.solr_parameters = { :'spellcheck.dictionary' => '' }

      # :solr_local_parameters will be sent using Solr LocalParams
      # syntax, as eg {! qf=$title_qf }. This is neccesary to use
      # Solr parameter de-referencing like $title_qf.
      # See: http://wiki.apache.org/solr/LocalParams
      field.solr_local_parameters = {
        :qf => '$content_qf',
        :pf => '$content_pf'
      }
    end    
    config.add_search_field('author') do |field|
      field.solr_parameters = { :'spellcheck.dictionary' => 'author' }
      field.solr_local_parameters = { 
        :qf => '$author_qf',
        :pf => '$author_pf'
      }
    end
    
    # Specifying a :qt only to show it's possible, and so our internal automated
    # tests can test it. In this case it's the same as 
    # config[:default_solr_parameters][:qt], so isn't actually neccesary. 
    #config.add_search_field('subject') do |field|
    #  field.solr_parameters = { :'spellcheck.dictionary' => 'subject' }
    #  field.qt = 'search'
    #  field.solr_local_parameters = { 
    #    :qf => '$subject_qf',
    #    :pf => '$subject_pf'
    #  }
    #end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'score desc, pub_date_sort desc, title_sort asc', :label => 'relevance'
    #config.add_sort_field 'pub_date_sort desc, title_sort asc', :label => 'year'
    #config.add_sort_field 'author_sort asc, title_sort asc', :label => 'author'
    config.add_sort_field 'title_sort asc, pub_date_sort desc', :label => 'title'

    # If there are more than this many search results, no spelling ("did you 
    # mean") suggestion is offered.
    config.spell_max = 5
  end

end 
