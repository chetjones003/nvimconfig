# My Neovim configuration

I prefer to stick as close to default neovim as much as possible. I have set up LSP with a few quality of life changes.

Installation (Linux-Ubuntu)

If you already have a nvim setup
```shell
mv .config/nvim .cache/nvim.bak
mv .local/share/nvim .cache/share/nvim.bak
rm -rf .config/nvim
rm -rf .local/share/nvim
```

```shell
mkdir .config/nvim
cd .config/nvim
git init
git remote add origin https://github.com/chetjones003/nvimconfig.git
git pull origin main
```

Make sure you have [Packer](https://github.com/wbthomason/packer.nvim) installed
```shell
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
```

You may need to source `.config/nvim/init.lua` and `.config/nvim/lua/cj/init.lua` then source `.config/nvim/lua/cj/packer.lua` individually.
Then you can execute `:PackerSync`
