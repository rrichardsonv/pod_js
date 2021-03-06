defmodule PodJsTest do
  use ExUnit.Case

  defmodule TestMod do
    use PodJs

    def page_script_path(path), do: path

    def every_script_path(path) do
      "#{path}/every"
    end

    def to_entry_point(path) do
      "entry/#{path}"
    end

    def script_tag(src) do
      "<SCRIPT>#{src}</SCRIPT>"
    end
  end

  test "TestMod.precompile/1" do
    template = """
        <div>Foo</div>
        """
    result =
      TestMod.precompile(
        template,
        "PATH",
        fn _ -> true end
      )

    assert String.contains?(result, template)
    assert String.contains?(result, "<!-- Generated by pod_js -->")
    assert String.contains?(result, "<SCRIPT>entry/PATH/every<SCRIPT>")
    assert String.contains?(result, "<SCRIPT>entry/PATH<SCRIPT>")
  end
end
