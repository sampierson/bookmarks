module ColumnsHelper
  
  #def make_column_drop_target(column)
  #  drop_receiving_element(column.dom_id,
  #    :accept     => 'section',
  #    :before     => "$('spinner').show();",
  #    :complete   => "$('spinner').hide();",
  #    :hoverclass => 'hover',
  #    :with       => "'id=' + encodeURIComponent(element.id.split('_').last())",
  #    :url        => drop_section_path(:column_id => column.id))
  #end
  
  # When all columns are defined, we activate sortables.
  # So we can move sections between columns, all coulmns must be listed in the :containment option for the sortable.
  def make_columns_sortable
    all_columns = @page.columns.map(&:dom_id)
    @page.columns.map do |column|
      sortable_element(column.dom_id,
        :url          => sort_sections_path(:column_id => column.id),
        :containment  => all_columns,
        :dropOnEmpty  => true,
        :hoverclass   => "'hover'" )
    end
  end
  
end
