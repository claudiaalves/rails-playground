class EmployeePresenter
  def initialize(controller, view, employee)
    @controller = controller
    @view = view
    @employee = employee
  end

  def display_employee_list
    @view.render partial: "employee_list", locals: {employee: @employee, heading: "Empregado"} 
  end

  def display_rocket_actions_associated
    if @employee.rocket_actions.size > 0 
      @view.render partial: "rockets_table", locals: {rocket_actions: @employee.rocket_actions, heading: "Rocket Actions associados"} 
    else 
      @view.content_tag :h3, "Não existem rocket actions associados!"
    end
  end

  def generate_new_rocket_link
    @view.link_to "Criar Rocket Action", path(:new_rocket_action_path, employee_id: @employee.id)
  end

  def generate_associate_rocket_link
    @view.link_to "Associar um Rocket Action", path(:associate_rocket_action_to_employee_path, employee_id: @employee.id)
  end

  def generate_index_employees_link
    @view.content_tag :p do
      @view.content_tag :strong, @view.link_to("Ver Empregados", path(:employees_path))
    end
  end

  private
  def path(sym, args=nil)
    @controller.send(sym, args)
  end
end