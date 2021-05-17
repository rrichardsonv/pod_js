# PodJs

Supports code splitting javascript in phoenix apps per template by dynamically generating entries
and appending script tags to compiled templates.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `pod_js` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:pod_js, "~> 0.1.0"}
  ]
end
```


In configuration of your phoenix app add:

```elixir
config :phoenix, :template_engines, eex: PodJs
```

In the webpack config add:
```js
const globViewEntries = () => {
  return glob.sync('../lib/*/templates/**/*.js').reduce((agg, p) => {
    const k = p.replace('.js', '')
               .split('/') // split on path segments
               .slice(-2) // take the filename and containing dir
               .join('-'); // kebab-case them

    return { ...agg, [k]: [p] };
  }, {})
}
```

and to your entries:

``` js
{
  // ...
  entry: {
    'app': glob.sync('./vendor/**/*.js').concat(['./js/app.js']),
    ...globViewEntries()
  },
  // ...
}
```

Its recommended that you alias your js folders in the webpack config as well.
For a assets folder that looks like this:

```
/assets
  /static
  /css
  /js
    /lib
    /api
    /components
```

Something like this is what we've found works best:

```js
    resolve: {
      extensions: [".js", ".ts"],
      alias: {
        '@lib': path.resolve(__dirname, "js/lib"),
        '@api': path.resolve(__dirname, "js/lib"),
        '@components': path.resolve(__dirname, "js/lib")
      },
      modules: [path.resolve(__dirname, "js"), "node_modules"],
    },
```

So then you can avoid any complexity in path resolution from scripts in your templates directory:
```js
import foo from '@lib/foo';
import MyButton from '@components/MyButton';
import _ from 'lodash';
import { createUser } from '@api/users';
```