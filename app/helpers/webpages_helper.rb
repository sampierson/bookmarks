module WebpagesHelper
  
  # When all columns are defined, we activate sortables.
  # So we can move sections between columns, all coulmns must be listed in the :containment option for the sortable.
  def make_sections_sortable
    all_column_ids = @page.columns.map { |col| col.droptarget_id } 
    @page.columns.map do |column|
      sortable_element(column.droptarget_id,
        :url          => sort_sections_path(:id => column.id),
        :containment  => all_column_ids,
        :dropOnEmpty  => true,
        :hoverclass   => "'hover'" )
    end
  end
  
  def make_bookmarks_sortable
    all_sections = Section.find(:all,
      :select => "s.*",
      :from => "sections AS s, columns AS c, webpages AS w",
      :conditions => [ "s.column_id = c.id AND c.webpage_id = w.id AND w.id = ?", @page.id ] )
    all_section_dom_ids = all_sections.map(&:droptarget_id)
    all_sections.map do |section|
      sortable_element(section.droptarget_id,
        :url          => sort_bookmarks_path(:id => section.id),
        :containment  => all_section_dom_ids,
        :dropOnEmpty  => true,
        :hoverclass   => "'hover'" )
    end
  end
  
end
