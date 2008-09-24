# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Routines that must be called from the context of a JavaScript Generator
  
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
  
  def rjs_make_sections_sortable(webpage)
    all_columns = webpage.columns.map(&:droptarget_id)
    webpage.columns.each do |column|
      page.sortable(column.droptarget_id,
        :url => sort_sections_path(:id => column.id),
        :containment  => all_columns,
        :dropOnEmpty  => true,
        :hoverclass   => "'hover'" )
    end
  end
  
  def rjs_destroy_section_sortables(webpage, except_this_column = nil)
    webpage.columns.each do |column|
      page << "Sortable.destroy(#{column.droptarget_id});" unless column == except_this_column
    end
  end
  
end
