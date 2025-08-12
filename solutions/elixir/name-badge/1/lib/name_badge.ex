defmodule NameBadge do
  def print(id, name, department) do
    department = if is_nil(department), do: "owner", else: department

    if is_nil(id) do
      "#{name} - #{String.upcase(department)}"
    else
      "[#{id}] - #{name} - #{String.upcase(department)}"
    end
  end
end