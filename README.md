# AI notebooks

This repo helps you to run Jupyter notebooks with a local Ollama LLM.

The long-term aim is to provide a containerised, hardened, local-only,
agentic notebook runner using [Jupyter](https://jupyter.org).

The instructions here that you have Python 3 installed and available on your
local machine. They also assume that you are starting the scripts from the root
directory of this repository.

The notebooks themselves will be saved to the `notebooks` directory, which will
be created automatically if it does not exist.

Note that the use of Ollama and the choice of model are currently hard-coded. A
chunk of work would be needed to make that more configurable.

## Authentication between the browser and the notebook

The scripts here create a file called `.env` which includes a token used
to authenticate the browser with the running notebook. You can either copy this
from the file and paste the value into a form in your browser, or (better)
copy the longer URL that includes the token from the script output and view
that in your browser.

The token in the `.env` file will be re-used between invocations of the `serve`
script, but to regenerate it just delete the file and re-run the script.

## Usage

In one terminal, start Ollama:

```sh
./scripts/serve-ollama
```

Note that this starts Ollama in the foreground.

In another terminal, run the notebook either without logging:

```sh
./scripts/serve --no-logs
```

Note that the `serve` script will tail logs if you don't pass in `--no-logs` or
`-n`, but if you do want to see the logs you need to watch out for a couple of
lines like this before they scroll past:

```sh
===> Notebook available at:
  http://localhost:8888/lab?token=verylonghexkeygoeshere
===> Remember to run this command in a notebook cell:
  %load_ext jupyter_ai_magics
```

Inside the notebook run this to ensure you have
[%ai and %%ai magic](https://jupyter-ai.readthedocs.io/en/v3/) available:

```python
%load_ext jupyter_ai_magics
```

## Troubleshooting

### I'm seeing `Kernel does not exist` errors in the logs

It is likely that your browser is trying to connect to a stale kernel.
Hard-refresh your browser tab to fix.

### I can't see a notebook at http://localhost:8888/lab

The `serve` script will tail logs by default, but before it flies past look for
something like:

```sh
===> Notebook available at:
  http://localhost:8888/lab?token=verylonghexkeygoeshere
```

to get the full URL of the notebook, including the token.

### My notebook can't talk to the AI

Make sure you run this in a cell before you start:

```python
%load_ext jupyter_ai_magics
```
