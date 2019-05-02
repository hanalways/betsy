module ApplicationHelper
  def error_list(model_errors)
    error_list = ""
    error_list += "<ul>"
    model_errors.each do |column, error|
      error.each do |message|
        error_list += "<li>#{column}: #{message}</li>"
      end

      error_list += "</ul>"
    end
    return error_list.html_safe
  end
end
