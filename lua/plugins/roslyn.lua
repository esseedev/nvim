return {
  {
    'seblyng/roslyn.nvim',
    ft = { 'cs', 'razor' },
    config = function(_, opts)
      require('roslyn').setup(opts)
    end,
    opts = {
      settings = {
        ['csharp|completion'] = {
          dotnet_show_completion_items_from_unimported_namespaces = true,
        },
        ['csharp|inlay_hints'] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        ['csharp|code_lens'] = {
          dotnet_enable_references_code_lens = true,
        },
      },
    },
  },
}
