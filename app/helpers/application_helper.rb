module ApplicationHelper
  def flash_class
    {
      'notice' => 'alert alert-info',
      'success' => 'alert alert-success',
      'error' => 'alert alert-danger',
      'alert' => 'alert alert-danger'
    }
  end
end
