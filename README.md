# nvim-telemake

An nvim extension which uses
[telescope](https://github.com/nvim-telescope/telescope.nvim) to show select
and execute Makefile targets.

## Installation

Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use 'nvim-telescope/telescope.nvim'
use 'ChSotiriou/nvim-telemake'
```

---

Configure telescope to load the extension in the nvim config file:

```lua
require("telescope").load_extension("telemake")
-- Add it as a key map (<leader>fm)
vim.api.nvim_set_keymap('n', '<leader>fm', '<cmd>Telescope telemake<cr>', { noremap = true, silent = true })
```


