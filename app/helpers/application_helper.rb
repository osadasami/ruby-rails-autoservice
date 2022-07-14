module ApplicationHelper
  def link_order(text, path, key)
    direction = params[key] == 'asc' ? 'desc' : 'asc'
    new_params = params.reject { |k, _| k.to_s.include? 'order_by' }
    link_to text, method(path).call(new_params.permit!.merge(key => direction))
  end
end
