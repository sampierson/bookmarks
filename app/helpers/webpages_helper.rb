module WebpagesHelper
  
  # When all columns are defined, we activate sortables.
  # So we can move sections between columns, all coulmns must be listed in the :containment option for the sortable.
  def make_columns_sortable
    all_columns = @page.columns.map(&:dom_id)
    @page.columns.map do |column|
      sortable_element(column.dom_id,
        :url          => sort_sections_path(:id => column.id),
        :containment  => all_columns,
        :dropOnEmpty  => true,
        :hoverclass   => "'hover'" )
    end
  end
  
end
