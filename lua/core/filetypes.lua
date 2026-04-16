vim.filetype.add {
  extension = {
    razor = 'razor',
    cshtml = 'razor',
  },
}

pcall(vim.treesitter.language.register, 'html', 'razor')
