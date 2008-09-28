module WebpagesHelper
  
  # When all columns are defined, we activate sortables.
  # So we can move sections between columns, all coulmns must be listed in the :containment option for the sortable.
  def make_columns_sortable
    all_column_ids = @page.columns.map { |col| col.droptarget_id } 
    @page.columns.map do |column|
      sortable_element(column.droptarget_id,
        :url          => sort_sections_path(:id => column),
        :containment  => all_column_ids,
        :dropOnEmpty  => true,
        :hoverclass   => "'hover'" )
    end
  end
  
  # Note that for nested Scritaculous Sortables to work, the inner sortable must be created first.
  # i.e. create section sortables before column sortables.
  def make_sections_sortable
    all_sections = @page.sections
    all_section_dom_ids = all_sections.map(&:droptarget_id)
    all_sections.map do |section|
      sortable_element(section.droptarget_id,
        :url          => sort_bookmarks_path(:id => section),
        :containment  => all_section_dom_ids,
        :dropOnEmpty  => true,
        :hoverclass   => "'hover'" )
    end
  end
  
end
