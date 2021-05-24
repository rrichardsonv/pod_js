defmodule PodJs.Kebab do
  @moduledoc """
  kebab-case strategy for naming js files

  * `page_script_path` - the way to go from template path to its associated script
  * `every_script_path` - the way to go from template path to the aggregate script its associated with
  * `to_entry_point` - the naming convention you intend to use in your js bundling
  * `script_tag` - the string template of the html script tag to inject
  """
  use PodJs

  def page_script_path(path) do
    String.replace_trailing(path, ".html.eex", ".js")
  end

  def every_script_path(path) do
    path
    |> Path.dirname()
    |> Path.join("every.js")
  end

  def to_entry_point(path) do
    path
    |> Path.split()
    |> Enum.reverse()
    |> Enum.take(2)
    |> Enum.reverse()
    |> Enum.join("-")
  end

  def script_tag(src) do
    """
    <script defer type="text/javascript" src="<%= Routes.static_path(@conn, "/js/#{src}") %>"></script>
    """
  end
end
