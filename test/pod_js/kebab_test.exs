defmodule PodJs.KebabTest do
  use ExUnit.Case
  alias PodJs.Kebab

  test "page_script_path/1 replaces the extension with js" do
    assert "foo/bar.js" == Kebab.page_script_path("foo/bar.html.eex")
  end

  test "every_script_path/1 replaces the template with every.js" do
    assert "foo/every.js" == Kebab.every_script_path("foo/bar.html.eex")
  end

  test "to_entry_point/1 dash separates the dirname and file and strips the rest" do
    assert "foo-bar.js" == Kebab.to_entry_point("foo/bar/baz.js")
  end

  test "script_tag/1 returns binary html with defer and the path in src" do
    tag = Kebab.script_tag("foo-bar.js")

    assert String.contains?(tag, "<script")
    assert String.contains?(tag, "defer")
    assert String.contains?(tag, ~s|src="<%=|)
    assert String.contains?(tag, "foo-bar.js")
  end
end
