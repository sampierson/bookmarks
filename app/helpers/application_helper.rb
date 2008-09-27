# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # From http://www.eribium.org/blog/?p=165
  def button_to_remote(name, options = {}, html_options = {})
    html_options = html_options.stringify_keys
    convert_boolean_attributes!(html_options, %w( disabled ))
    method_tag = ''
    if (method = html_options.delete('method')) && %w{put delete}.include?(method.to_s)
      method_tag = tag('input', :type => 'hidden', :name => '_method', :value => method.to_s)
      options.merge!(:method => method.to_s)
    end
    if confirm = html_options.delete("confirm")
      html_options["onclick"] = "return #{confirm_javascript_function(confirm)};"
    end
    before_html = html_options.delete('before') || ''
    after_html = html_options.delete('after') || ''
    url = options.is_a?(String) ? options : self.url_for(options)
    name ||= url
    options.merge!(:html => {:class => 'button-to'})
    form_remote_tag(options) + method_tag + before_html + tag("button", html_options, true) + name + '</button>' + after_html + '</form>'
  end
   
  # Routines that must be called from the context of a JavaScript Generator (variable 'page' is set).
  
  def ajax_flash_message(message)
    flash_mode = :stacking
    if flash_mode == :simple
      page.replace_html 'flash_container', "<div class=\"flash flash-notice\">#{message}</div>"
      page.visual_effect(:appear, 'flash', :duration => 1)
      #page.visual_effect(:blind_down, 'flash', :duration => 1)
      page.visual_effect(:fade, 'flash', :delay => 5, :duration => 1)
      page.visual_effect(:blind_up, 'flash', :delay => 5, :duration => 1)
    else
      flash_id = Time.now.strftime("flash_%H%M%S")
      page.insert_html :bottom, 'flash_container', "<div id=#{flash_id} class=\"flash flash-notice\">#{message}</div>"
      page.visual_effect(:appear, flash_id, :duration => 1)
      page.visual_effect(:blind_down, flash_id, :duration => 1)
      page.visual_effect(:fade, flash_id, :delay => 5, :duration => 1)
      page.visual_effect(:blind_up, flash_id, :delay => 5, :duration => 1, :afterFinish => "function() { #{flash_id}.remove(); }")
    end
  end
  
  # Note that for nested Scritaculous Sortables to work, the inner sortable must be created first.
  # i.e. create section sortables before column sortables.
  
  def rjs_create_column_sortables(column_data)
    all_columns = column_data.map { |c| c[:droptarget_id] }
    column_data.each do |cdata|
      page.sortable(cdata[:droptarget_id],
                    :url => cdata[:url],
                    :containment => all_columns,
                    :dropOnEmpty  => true,
                    :hoverclass   => "'hover'" )
    end
  end
  
  def rjs_create_section_sortables(section_data)
    all_sections = section_data.map { |s| s[:droptarget_id] }
    column_data.each do |cdata|
      page.sortable(cdata[:droptarget_id],
                    :url => cdata[:url],
                    :containment => all_sections,
                    :dropOnEmpty  => true,
                    :hoverclass   => "'hover'" )
    end
  end
  
  def rjs_destroy_column_sortables_for_webpage(webpage, options = {})
    webpage.columns.each do |column|
      next if column == options[:except_column]
      page << "Sortable.destroy(#{column.droptarget_id});"
    end
  end
  
  def rjs_destroy_section_sortables_for_webpage(webpage, options = {})
    webpage.columns.each do |column|
      next if column == options[:except_column]
      rjs_destroy_section_sortables_for_column(column, options)
    end
  end
  
  def rjs_destroy_section_sortables_for_column(column, options = {})
    column.sections.each do |section|
      next if section == options[:except_section]
      page << "Sortable.destroy(#{section.droptarget_id});"
    end
  end
  
end

