# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Routines that must be called from the context of a JavaScript Generator
  
  def ajax_flash_message(message)
    flash_mode = :stacking
    if flash_mode == :simple
      page.replace_html 'flash', "<div class=flash-notice>#{message}</div>"
      page.visual_effect(:appear, 'flash', :duration => 1)
      #page.visual_effect(:blind_down, 'flash', :duration => 1)
      page.visual_effect(:fade, 'flash', :delay => 5, :duration => 1)
      page.visual_effect(:blind_up, 'flash', :delay => 5, :duration => 1)
    else
      flash_id = Time.now.strftime("flash_%H%M%S")
      page.insert_html :bottom, 'flash', "<div id=#{flash_id} class=flash-notice>#{message}</div>"
      page.visual_effect(:appear, flash_id, :duration => 1)
      page.visual_effect(:blind_down, flash_id, :duration => 1)
      page.visual_effect(:fade, flash_id, :delay => 5, :duration => 1)
      page.visual_effect(:blind_up, flash_id, :delay => 5, :duration => 1, :afterFinish => "function() { #{flash_id}.remove(); }")
    end
  end
  
  def rjs_make_columns_sortable(webpage)
    all_columns = webpage.columns.map(&:dom_id)
    webpage.columns.each do |column|
      page.sortable( column.dom_id,
        :url => sort_sections_path(:id => column.id),
        :containment  => all_columns,
        :dropOnEmpty  => true,
        :hoverclass   => "'hover'" )
    end
  end
  
  def rjs_destroy_column_sortables(webpage, except_this_column = nil)
    webpage.columns.each do |column|
      page << "Sortable.destroy(#{column.dom_id});" unless column == except_this_column
    end
  end
  
end
