{"filter":false,"title":"tag_generator.rb","tooltip":"/plugins/tag_generator.rb","ace":{"folds":[],"scrolltop":841.5,"scrollleft":0,"selection":{"start":{"row":65,"column":57},"end":{"row":65,"column":57},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":true,"wrapToView":false},"firstLineState":{"row":12,"state":"start","mode":"ace/mode/ruby"}},"hash":"0761514a01a5e9ddd59841b6d6cbaf7fa7d4b2db","undoManager":{"mark":96,"position":96,"stack":[[{"group":"doc","deltas":[{"start":{"row":0,"column":0},"end":{"row":174,"column":0},"action":"insert","lines":["# encoding: utf-8","#","# Jekyll tag page generator.","# http://recursive-design.com/projects/jekyll-plugins/","#","# Version: 0.1.4 (201101061053)","#","# Copyright (c) 2010 Dave Perrett, http://recursive-design.com/","# Licensed under the MIT license (http://www.opensource.org/licenses/mit-license.php)","#","# A generator that creates tag pages for jekyll sites.","#","# Included filters :","# - tag_links:      Outputs the list of tags as comma-separated <a> links.","# - date_to_html_string: Outputs the post.date as formatted html, with hooks for CSS styling.","#","# Available _config.yml settings :","# - tag_dir:          The subfolder to build tag pages in (default is 'tags').","# - tag_title_prefix: The string used before the tag name in the page title (default is","#                          'Related Articles:  ').","","module Jekyll","","  # The TagIndex class creates a single tag page for the specified tag.","  class TagIndex < Page","","    # Initializes a new TagIndex.","    #","    #  +base+         is the String path to the <source>.","    #  +tag_dir+ is the String path between <source> and the tag folder.","    #  +tag+     is the tag currently being processed.","    def initialize(site, base, tag_dir, tag)","      @site = site","      @base = base","      @dir  = tag_dir","      @name = 'index.html'","      self.process(@name)","      # Read the YAML data from the layout page.","      self.read_yaml(File.join(base, '_layouts'), 'tag_index.html')","      self.data['tag']    = tag","      # Set the title for this page.","      title_prefix             = site.config['tag_title_prefix'] || 'Related Articles: '","      self.data['title']       = \"#{title_prefix}#{tag}\"","      # Set the meta-description for this page.","      meta_description_prefix  = site.config['tag_meta_description_prefix'] || 'Related Articles: '","      self.data['description'] = \"#{meta_description_prefix}#{tag}\"","    end","","  end","","  # The TagFeed class creates an Atom feed for the specified tag.","  class TagFeed < Page","","    # Initializes a new TagFeed.","    #","    #  +base+         is the String path to the <source>.","    #  +tag_dir+ is the String path between <source> and the tag folder.","    #  +tag+     is the tag currently being processed.","    def initialize(site, base, tag_dir, tag)","      @site = site","      @base = base","      @dir  = tag_dir","      @name = 'atom.xml'","      self.process(@name)","      # Read the YAML data from the layout page.","      self.read_yaml(File.join(base, '_includes/custom'), 'tag_feed.xml')","      self.data['tag']    = tag","      # Set the title for this page.","      title_prefix             = site.config['tag_title_prefix'] || 'Related Articles: '","      self.data['title']       = \"#{title_prefix}#{tag}\"","      # Set the meta-description for this page.","      meta_description_prefix  = site.config['tag_meta_description_prefix'] || 'Related Articles: '","      self.data['description'] = \"#{meta_description_prefix}#{tag}\"","","      # Set the correct feed URL.","      self.data['feed_url'] = \"#{tag_dir}/#{name}\"","    end","","  end","","  # The Site class is a built-in Jekyll class with access to global site config information.","  class Site","","    # Creates an instance of TagIndex for each tag page, renders it, and","    # writes the output to a file.","    #","    #  +tag_dir+ is the String path to the tag folder.","    #  +tag+     is the tag currently being processed.","    def write_tag_index(tag_dir, tag)","      index = TagIndex.new(self, self.source, tag_dir, tag)","      index.render(self.layouts, site_payload)","      index.write(self.dest)","      # Record the fact that this page has been added, otherwise Site::cleanup will remove it.","      self.pages << index","","      # Create an Atom-feed for each index.","      feed = TagFeed.new(self, self.source, tag_dir, tag)","      feed.render(self.layouts, site_payload)","      feed.write(self.dest)","      # Record the fact that this page has been added, otherwise Site::cleanup will remove it.","      self.pages << feed","    end","","    # Loops through the list of tag pages and processes each one.","    def write_tag_indexes","      if self.layouts.key? 'tag_index'","        dir = self.config['tag_dir'] || 'tags'","        self.tags.keys.each do |tag|","          self.write_tag_index(File.join(dir, tag.gsub(/_|\\P{Word}/, '-').gsub(/-{2,}/, '-').downcase), tag)","        end","","      # Throw an exception if the layout couldn't be found.","      else","        throw \"No 'tag_index' layout found.\"","      end","    end","","  end","","","  # Jekyll hook - the generate method is called by jekyll, and generates all of the tag pages.","  class GenerateTags < Generator","    safe true","    priority :low","","    def generate(site)","      site.write_tag_indexes","    end","","  end","","","  # Adds some extra filters used during the tag creation process.","  module Filters","","    # Outputs a list of tags as comma-separated <a> links. This is used","    # to output the tag list for each post on a tag page.","    #","    #  +tags+ is the list of tags to format.","    #","    # Returns string","    #","    def tag_links(tags)","      dir = @context.registers[:site].config['tag_dir']","      tags = tags.sort!.map do |item|","        \"<a class='tag' href='/#{dir}/#{item.gsub(/_|\\P{Word}/, '-').gsub(/-{2,}/, '-').downcase}/'>#{item}</a>\"","      end","","      case tags.length","      when 0","        \"\"","      when 1","        tags[0].to_s","      else","        \"#{tags[0...-1].join(', ')}, #{tags[-1]}\"","      end","    end","","    # Outputs the post.date as formatted html, with hooks for CSS styling.","    #","    #  +date+ is the date object to format as HTML.","    #","    # Returns string","    def date_to_html_string(date)","      result = '<span class=\"month\">' + date.strftime('%b').upcase + '</span> '","      result += date.strftime('<span class=\"day\">%d</span> ')","      result += date.strftime('<span class=\"year\">%Y</span> ')","      result","    end","","  end","","end","",""]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":69},"end":{"row":41,"column":70},"action":"insert","lines":["T"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":70},"end":{"row":41,"column":71},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":71},"end":{"row":41,"column":72},"action":"insert","lines":["g"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":72},"end":{"row":41,"column":73},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":["R"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":["d"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":["A"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"remove","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":80},"end":{"row":44,"column":96},"action":"remove","lines":["Related Articles"]},{"start":{"row":44,"column":80},"end":{"row":44,"column":81},"action":"insert","lines":["T"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":81},"end":{"row":44,"column":82},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":82},"end":{"row":44,"column":83},"action":"insert","lines":["g"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":83},"end":{"row":44,"column":84},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":53},"end":{"row":65,"column":54},"action":"remove","lines":["m"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":52},"end":{"row":65,"column":53},"action":"remove","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":51},"end":{"row":65,"column":52},"action":"remove","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":50},"end":{"row":65,"column":51},"action":"remove","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":49},"end":{"row":65,"column":50},"action":"remove","lines":["u"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":48},"end":{"row":65,"column":49},"action":"remove","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":47},"end":{"row":65,"column":48},"action":"remove","lines":["/"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":72},"end":{"row":41,"column":73},"action":"remove","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":71},"end":{"row":41,"column":72},"action":"remove","lines":["g"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":70},"end":{"row":41,"column":71},"action":"remove","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":69},"end":{"row":41,"column":70},"action":"remove","lines":["T"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":69},"end":{"row":41,"column":70},"action":"insert","lines":["R"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":70},"end":{"row":41,"column":71},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":71},"end":{"row":41,"column":72},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":72},"end":{"row":41,"column":73},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":73},"end":{"row":41,"column":74},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":74},"end":{"row":41,"column":75},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":75},"end":{"row":41,"column":76},"action":"insert","lines":["d"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":76},"end":{"row":41,"column":77},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":77},"end":{"row":41,"column":78},"action":"insert","lines":["A"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":78},"end":{"row":41,"column":79},"action":"insert","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":79},"end":{"row":41,"column":80},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":80},"end":{"row":41,"column":81},"action":"insert","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":81},"end":{"row":41,"column":82},"action":"insert","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":82},"end":{"row":41,"column":83},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":83},"end":{"row":41,"column":84},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":41,"column":84},"end":{"row":41,"column":85},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":83},"end":{"row":44,"column":84},"action":"remove","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":82},"end":{"row":44,"column":83},"action":"remove","lines":["g"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":81},"end":{"row":44,"column":82},"action":"remove","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":80},"end":{"row":44,"column":81},"action":"remove","lines":["T"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":80},"end":{"row":44,"column":81},"action":"insert","lines":["R"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":81},"end":{"row":44,"column":82},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":82},"end":{"row":44,"column":83},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":83},"end":{"row":44,"column":84},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":84},"end":{"row":44,"column":85},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":85},"end":{"row":44,"column":86},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":86},"end":{"row":44,"column":87},"action":"insert","lines":["d"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":87},"end":{"row":44,"column":88},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":88},"end":{"row":44,"column":89},"action":"insert","lines":["A"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":89},"end":{"row":44,"column":90},"action":"insert","lines":["r"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":90},"end":{"row":44,"column":91},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":91},"end":{"row":44,"column":92},"action":"insert","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":92},"end":{"row":44,"column":93},"action":"insert","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":93},"end":{"row":44,"column":94},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":94},"end":{"row":44,"column":95},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":95},"end":{"row":44,"column":96},"action":"insert","lines":["z"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":95},"end":{"row":44,"column":96},"action":"remove","lines":["z"]}]}],[{"group":"doc","deltas":[{"start":{"row":44,"column":95},"end":{"row":44,"column":96},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":51},"end":{"row":65,"column":53},"action":"insert","lines":["''"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":52},"end":{"row":65,"column":53},"action":"insert","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":53},"end":{"row":65,"column":54},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":54},"end":{"row":65,"column":55},"action":"insert","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":55},"end":{"row":65,"column":56},"action":"insert","lines":["d"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":56},"end":{"row":65,"column":57},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":57},"end":{"row":65,"column":58},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":59},"end":{"row":65,"column":60},"action":"insert","lines":[","]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":60},"end":{"row":65,"column":61},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":38,"column":50},"end":{"row":38,"column":59},"action":"insert","lines":["'asides',"]}]}],[{"group":"doc","deltas":[{"start":{"row":38,"column":59},"end":{"row":38,"column":60},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":38,"column":59},"end":{"row":38,"column":60},"action":"remove","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":38,"column":58},"end":{"row":38,"column":59},"action":"remove","lines":[","]}]}],[{"group":"doc","deltas":[{"start":{"row":38,"column":57},"end":{"row":38,"column":59},"action":"remove","lines":["''"]}]}],[{"group":"doc","deltas":[{"start":{"row":38,"column":56},"end":{"row":38,"column":57},"action":"remove","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":38,"column":55},"end":{"row":38,"column":56},"action":"remove","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":38,"column":54},"end":{"row":38,"column":55},"action":"remove","lines":["d"]}]}],[{"group":"doc","deltas":[{"start":{"row":38,"column":53},"end":{"row":38,"column":54},"action":"remove","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":38,"column":52},"end":{"row":38,"column":53},"action":"remove","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":38,"column":51},"end":{"row":38,"column":52},"action":"remove","lines":["a"]}]}],[{"group":"doc","deltas":[{"start":{"row":38,"column":50},"end":{"row":38,"column":51},"action":"remove","lines":["'"]}]}],[{"group":"doc","deltas":[{"start":{"row":38,"column":50},"end":{"row":38,"column":51},"action":"insert","lines":["'"]}]}],[{"group":"doc","deltas":[{"start":{"row":65,"column":57},"end":{"row":65,"column":58},"action":"remove","lines":["s"]}]}]]},"timestamp":1423936003000}